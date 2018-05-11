module Administrate
  module Filter
    class Select
      def initialize(name, filter)
        @name = name
        @filter = filter
      end

      attr_reader :name, :filter

      def apply(relation)
        filter.call(relation)
      end

      def to_partial_path
        "/filters/#{self.class.field_type}/filter"
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
