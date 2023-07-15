class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: %i[ show edit update destroy ]

  # GET /purchase_invoices
  def index
    @purchase_invoices = PurchaseInvoice.search(params).select(:purchase_invoice_id, :company_id, :payment_account_number, :document_id, :issued_on, :supplier_name, :reference, :paid_on)
  end

  # GET /purchase_invoices/1
  def show
  end

  # GET /purchase_invoices/new
  def new
    @purchase_invoice = PurchaseInvoice.new_with_last_invoice_defaults(document_id: params[:document_id])
  end

  # GET /purchase_invoices/1/edit
  def edit
  end

  # POST /purchase_invoices
  def create
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)

    if @purchase_invoice.save
      if @purchase_invoice.document_id and Document.unprocessed.any?
        redirect_to new_purchase_invoice_path(document_id: Document.unprocessed.first)
      elsif @purchase_invoice.document_id and Document.unprocessed.empty?
        redirect_to purchase_invoices_path, notice: "There is no more document to process."
      else
        redirect_to edit_purchase_invoice_path(@purchase_invoice), notice: "Purchase invoice was successfully created."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchase_invoices/1
  def update
    if @purchase_invoice.update(purchase_invoice_params)
      redirect_to @purchase_invoice, notice: "Purchase invoice was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /purchase_invoices/1
  def destroy
    @purchase_invoice.destroy
    redirect_to purchase_invoices_url, notice: "Purchase invoice was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice
      @purchase_invoice = PurchaseInvoice.select(:purchase_invoice_id, :company_id, :document_id, :payment_account_number, :issued_on, :supplier_name, :reference, :paid_on).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_params
      filtered_params = params.require(:purchase_invoice).permit(:issued_on, :supplier_name, :reference, :payment_account_number, :paid_on, :document_id, :currency, lines_attributes: [:account_number, :amount, :tax_rate, :tax_account_number])
    end
  include CompanyDependent
end
