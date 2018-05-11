module Administrate
  module Filter
    class Text
      def initialize(name, filter)
        @name = name
        @filter = filter
      end

      attr_reader :name, :filter

      def apply(relation, value)
        filter.call(relation, value)
      end

      def to_partial_path
        "/filters/#{self.class.field_type}"
      end

      def label
        name.to_s.titleize
      end

      def self.field_type
        to_s.split("::").last.underscore
      end
    end
  end
end
