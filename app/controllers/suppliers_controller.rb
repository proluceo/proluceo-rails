class SuppliersController < ApplicationController
  def search
    @suppliers = Supplier.search(params).companys
    render layout: false
  end
  include CompanyDependent
end