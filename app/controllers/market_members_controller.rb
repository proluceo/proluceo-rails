class MarketMembersController < ApplicationController
  before_action :set_market_member, only: %i[ show edit update destroy ]

# GET /market_members
  def index
    @market_members = MarketMember.search(params)
  end

  # GET /market_members/1
  def show
  end

  # GET /market_members/new
  def new
    @market_member = MarketMember.new
  end

  # GET /market_members/1/edit
  def edit
  end

  # POST /market_members
  def create
    @market_member = MarketMember.new(market_member_params)

    if @market_member.save
        redirect_to edit_market_member_path(@market_member), notice: "Market Member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /market_members/1
  def update
    if @market_member.update(market_member_params)
      redirect_to @market_member, notice: "Market Member was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /market_members/1
  def destroy
    @market_member.destroy
    redirect_to market_members_url, notice: "Market Member was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_member
      @market_member = MarketMember.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def market_member_params
      filtered_params = params.require(:market_member).permit([:name, contacts_attributes: [:first_name, :last_name, :work_email, :phone]])
    end

end
