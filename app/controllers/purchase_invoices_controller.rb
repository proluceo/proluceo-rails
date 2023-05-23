class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: %i[ show edit update destroy ]

  # GET /purchase_invoices
  def index
    @purchase_invoices = PurchaseInvoice.select(:purchase_invoice_id, :company_id, :payment_account_number, :document_id, :issued_on, :supplier, :reference, :amount, :paid_on)
  end

  # GET /purchase_invoices/1
  def show
  end

  # GET /purchase_invoices/new
  def new
    @purchase_invoice = PurchaseInvoice.new(document_id: params[:document_id])
  end

  # GET /purchase_invoices/1/edit
  def edit
  end

  # POST /purchase_invoices
  def create
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)

    if @purchase_invoice.save
      redirect_to edit_purchase_invoice_path(@purchase_invoice), notice: "Purchase invoice was successfully created."
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
      @purchase_invoice = PurchaseInvoice.select(:purchase_invoice_id, :company_id, :document_id, :payment_account_number, :issued_on, :supplier, :reference, :amount, :paid_on).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_params
      params.require(:purchase_invoice).permit(:issued_on, :supplier, :reference, :payment_account_number, :paid_on, :document_id, :currency)
    end
  include CompanyDependent
end
