class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts
  def index
    #.where("sum_credit IS NOT NULL OR sum_debit IS NOT NULL")
    @accounts = AccountBalance.search(params[:q]).order("number::text")
  end

  def search
    @accounts = Account.search(params[:q])
    render layout: false
  end

  # GET /accounts/1
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @target = params[:target]
    @model = params[:model]
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  def create
    account = Account.new(account_params)
    @target = params[:target]
    @model = params[:model]

    success = account.save

    respond_to do |format|
      @account = AccountBalance.where(number: account.number).first
      if success and @target.present?
        format.turbo_stream
      elsif success
        format.turbo_stream { render turbo_stream: [turbo_stream.prepend("accounts", partial: 'accounts/account', locals: {account: @account}), turbo_stream.remove("form_account")] }
      else
        @account = account
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render @account
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy

    render turbo_stream: [
      turbo_stream.remove(@account)
    ]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params.extract_value(:id))
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:number, :label)
    end

end
