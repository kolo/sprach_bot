module Telegram
  class Type
    class Field
      attr_reader :name

      def initialize(name:, opts:)
        @name = name
        @opts = opts
      end

      def writer_method
        "#{name}="
      end

      def required
        !opts.fetch(:optional, false)
      end

      def type
        opts[:type]
      end

      def to_s
        name
      end

      private

      attr_reader :opts
    end
  end
end
