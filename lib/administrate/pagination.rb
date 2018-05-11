module Administrate
  class Pagination
    def initialize(relation, page, records_per_page)
      @relation = relation
      @page = page
      @records_per_page = records_per_page
    end

    def apply
      relation.page(page).per(records_per_page)
    end

    private

    attr_reader :relation, :page, :records_per_page
  end
end
