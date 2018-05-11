module Administrate
  class Filters
    def initialize(scoped_resource, dashboard_class, filter_params)
      @scoped_resource = scoped_resource
      @dashboard_class = dashboard_class
      @filter_params = filter_params
    end

    def apply
      results = scoped_resource
      if filter_params.present?
        filter_params.each do |name, value|
          results = apply_filter(name, value, results)
        end
      end
      results
    end

    private

    def apply_filter(filter_name, filter_value, scope)
      if apply_filter?(filter_name, filter_value)
        filter_index = registered_filters_index(filter_name)
        scope = registered_filters[filter_index].apply(scope, filter_value)
      else
        scope
      end
    end

    def apply_filter?(filter_name, filter_value)
      return false if filter_value.blank? || filter_value == [""]
      registered_filters_names.include?(filter_name.to_sym)
    end

    def registered_filters
      dashboard_class::COLLECTION_FILTERS
    end

    def registered_filters_names
      @registered_filters_names ||= registered_filters.map(&:name)
    end

    def registered_filters_index(filter_name)
      registered_filters_names.index(filter_name.to_sym)
    end

    attr_reader :scoped_resource, :dashboard_class, :filter_params
  end
end
