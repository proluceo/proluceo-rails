class PurchaseInvoices::LinesController < ApplicationController
  before_action :set_purchase_invoice_line, only: %i[ show edit update destroy ]

  # GET /purchase_invoice_lines
  def index
    @lines = PurchaseInvoiceLine.all
  end

  # GET /purchase_invoice_lines/1
  def show
  end

  # GET /purchase_invoice_lines/new
  def new
    @line = PurchaseInvoiceLine.new
  end

  # GET /purchase_invoice_lines/1/edit
  def edit
  end

  # POST /purchase_invoice_lines
  def create
    @line = PurchaseInvoiceLine.new(purchase_invoice_line_params)

    if @line.save
      redirect_to @line, notice: "Purchase invoice line was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchase_invoice_lines/1
  def update
    if @line.update(purchase_invoice_line_params)
      redirect_to @line, notice: "Purchase invoice line was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_invoice_lines/1
  def destroy
    @line.destroy
    redirect_to purchase_invoice_lines_url, notice: "Purchase invoice line was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice_line
      @line = PurchaseInvoiceLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_line_params
      params.require(:purchase_invoice_line).permit(:company_id, :account_number_id, :amount, :tax_rate, :tax_account_number_id)
    end
end
