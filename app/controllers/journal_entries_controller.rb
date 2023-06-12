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
    @ledger_entry = LedgerEntry.new
  end

  # GET /ledger_entries/1/edit
  def edit; end

  # POST /ledger_entries
  def create
    @ledger_entry = LedgerEntry.new(ledger_entry_params)

    if @ledger_entry.save
      redirect_to @ledger_entry, notice: 'Ledger entry was successfully created.'
    else
      render :new, status: :unprocessable_entity
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
    params.fetch(:ledger_entry, {})
  end

  include CompanyDependent
end
