require 'telegram/type/field'

module Telegram
  def self.define_type(typ, &block)
    klass = Class.new(Type)
    klass.define_fields(&block) if block

    const_set(typ, klass)
  end

  class Type
    class << self
      attr_accessor :fields

      def define_fields(&block)
        instance_eval(&block)
      end

      def field(name, opts = {})
        field = Field.new(name: name, opts: opts)
        define_accessor_methods(field)

        fields << field
      end

      def fields
        @fields ||= []
      end

      def define_accessor_methods(field)
        attr_accessor(field.name)
        private(field.writer_method)
      end
    end

    def initialize(attrs)
      self.class.fields.each do |field|
        set_value(field, attrs[field.name])
      end
    end

    private

    def set_value(field, value)
      if field.required && value.nil?
        raise ArgumentError.new("#{field} is required")
      end

      if field.type
        send(field.writer_method, Telegram::const_get(field.type).new(value))
      else
        send(field.writer_method, value)
      end
    end
  end
end
