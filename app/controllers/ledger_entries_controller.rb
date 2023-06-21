class LedgerEntriesController < ApplicationController
  before_action :set_ledger_entry, only: %i[show edit update destroy]

  # GET /ledger_entries
  def index
    @ledger_entries = LedgerEntry.companys
  end

  # GET /ledger_entries/1
  def show; end

  # GET /ledger_entries/new
  def new
    # @ledger_entry = LedgerEntry.new
    @parts = [LedgerEntry.new, LedgerEntry.new]
  end

  # GET /ledger_entries/1/edit
  def edit; end

  # POST /ledger_entries
  def create
    parts_attributes = ledger_entry_params[:parts].values

    if adding_new_line?
      @parts = []
      parts_attributes.each do |part|
        @parts << LedgerEntry.new(part)
      end
      @parts << LedgerEntry.new
      respond_to do |format|
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace("new_ledger_entry_form", partial: "ledger_entries/form", locals: { parts: @parts })
        ]}
      end
      return
    end

    # Set amount and position attributes based on credit and debit amount
    parts = []
    parts_attributes.each do |part|
      if part[:credit_amount].present?
        part[:amount] = part[:credit_amount]
        part[:direction] = "credit"
        part.delete(:credit_amount)
      elsif part[:debit_amount].present?
        part[:amount] = part[:debit_amount]
        part[:direction] = "debit"
        part.delete(:debit_amount)
      end
      part[:company_id] = current_company_id
      parts << part
    end

    respond_to do |format|
      if ledger_entries = LedgerEntry.create_from_parts(parts)
        format.turbo_stream { render turbo_stream: [
          turbo_stream.prepend("ledger_entries", partial: "ledger_entries/new_ledger_entry", collection: ledger_entries.to_a),
          turbo_stream.remove("form_ledger_entry")
        ]}
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /ledger_entries/1
  def update
    if @ledger_entry.update(ledger_entry_params)
      redirect_to @ledger_entry, notice: 'Ledger entry was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /ledger_entries/1
  def destroy
    @ledger_entry.destroy
    redirect_to ledger_entries_url, notice: 'Ledger entry was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ledger_entry
    @ledger_entry = LedgerEntry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ledger_entry_params
    params.require(:ledger_entry).permit(parts: [:position, :account_number, :debit_amount, :credit_amount])
    # params.fetch(:ledger_entry, {})
  end

  def adding_new_line?
    params[:commit] == "New line"
  end

  include CompanyDependent
end
