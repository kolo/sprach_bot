require 'telegram/type/dsl'
require 'telegram/type/field'

module Telegram
  def self.define_type(typ, &block)
    klass = Class.new(Type)
    klass.define_fields(&block) if block

    const_set(typ, klass)
  end

  class Type
    extend DSL

    def self.array(values)
      values.collect { |attrs| new(attrs) }
    end

    def initialize(attrs)
      attrs.symbolize_keys!
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
