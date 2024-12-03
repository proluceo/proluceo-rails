class PurchaseInvoices::LinesController < ApplicationController
  before_action :set_line, only: %i[ show edit update destroy ]

  # GET /purchase_invoice_lines
  def index
    @purchase_invoice = PurchaseInvoice.find(params[:purchase_invoice_id])
  end

  # POST /purchase_invoice_lines
  def create
    @line = PurchaseInvoiceLine.new(line_params.merge(purchase_invoice_id: params[:purchase_invoice_id]))
    @line.save
    @line.reload
    render :create, notice: "Purchase invoice line was successfully created."
  end

  # PATCH/PUT /purchase_invoice_lines/1
  def update
    if @line.update(line_params)
      @line.reload
      render :edit, notice: "Purchase invoice line was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_invoice_lines/1
  def destroy
    @line.destroy
    render :destroy, notice: "Purchase invoice line was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = PurchaseInvoiceLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_params
      params.require(:purchase_invoice_line).permit(:company_id, :account_number, :amount, :tax_rate, :tax_account_number)
    end

end
