module Telegram
  class Type
    module DSL
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
  end
end
