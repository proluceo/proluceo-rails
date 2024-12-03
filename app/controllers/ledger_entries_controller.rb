class LedgerEntriesController < ApplicationController
  before_action :set_ledger_entry, only: %i[show edit update destroy]

  # GET /ledger_entries
  def index
    @ledger_entries = FormattedLedgerEntry.order(:value_on)
    @ledger_entries = @ledger_entries.for_account(params[:account_number].to_i)
  end

  # GET /ledger_entries/1
  def show; end

  # GET /ledger_entries/new
  def new
    @ledger_entry = LedgerEntry.new
  end

  # GET /ledger_entries/1/edit
  def edit; end

  # POST /ledger_entries
  def create
    @ledger_entry = LedgerEntry.new(ledger_entry_params)
    success = @ledger_entry.save

    respond_to do |format|
      format.turbo_stream do
        if success
          render turbo_stream: [
            turbo_stream.prepend("ledger_entries", partial: "ledger_entries/ledger_entry", locals: { ledger_entry: @ledger_entry.formatted }),
            turbo_stream.remove("form_ledger_entry")
          ]
        else
          #render turbo_stream: [ turbo_stream.prepend("ledger_entries", partial: "ledger_entries/ledger_entry", locals: { ledger_entry: @ledger_entry }) ]
          render :new, status: :unprocessable_entity
        end
      end
      format.html do
        if success
          return redirect_to ledger_entries_path
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /ledger_entries/1
  def update
    # TODO: Warning, possible SQL injection risk. Also missing tenant scope enforcement.
    ActiveRecord::Base.connection.execute("DELETE FROM accounting.ledger_entry_parts WHERE ledger_entry_id='#{@ledger_entry.ledger_entry_id}'")
    @ledger_entry.parts.reset
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
    params.require(:ledger_entry).permit([:value_on, :label, parts_attributes: [:account_number, :account_input, :debit_amount, :credit_amount]])
  end

  def adding_new_line?
    params[:commit] == "New line"
  end


end
