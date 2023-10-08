class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.search(params)
  end

  def new
    @supplier = Supplier.new
    @target = params[:target]
    @model = params[:model]
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @target = params[:target]
    @model = params[:model]

    respond_to do |format|
      if @supplier.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    @suppliers = Supplier.search(params)
    render layout: false
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :invoices_in)
  end

end