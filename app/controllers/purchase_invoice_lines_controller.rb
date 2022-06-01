class PurchaseInvoiceLinesController < ApplicationController
  before_action :set_purchase_invoice_line, only: %i[ show edit update destroy ]

  # GET /purchase_invoice_lines
  def index
    @purchase_invoice_lines = PurchaseInvoiceLine.all
  end

  # GET /purchase_invoice_lines/1
  def show
  end

  # GET /purchase_invoice_lines/new
  def new
    @purchase_invoice_line = PurchaseInvoiceLine.new
  end

  # GET /purchase_invoice_lines/1/edit
  def edit
  end

  # POST /purchase_invoice_lines
  def create
    @purchase_invoice_line = PurchaseInvoiceLine.new(purchase_invoice_line_params)

    if @purchase_invoice_line.save
      redirect_to @purchase_invoice_line, notice: "Purchase invoice line was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchase_invoice_lines/1
  def update
    if @purchase_invoice_line.update(purchase_invoice_line_params)
      redirect_to @purchase_invoice_line, notice: "Purchase invoice line was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_invoice_lines/1
  def destroy
    @purchase_invoice_line.destroy
    redirect_to purchase_invoice_lines_url, notice: "Purchase invoice line was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice_line
      @purchase_invoice_line = PurchaseInvoiceLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_line_params
      params.fetch(:purchase_invoice_line, {})
    end
end
