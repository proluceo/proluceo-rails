class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy select ]

  # GET /companies
  def index
    ActsAsTenant.without_tenant do
      @companies = Company.all
    end
  end

  # GET /companies/1
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to companies_path, notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to companies_url, notice: "Company was successfully destroyed."
  end

  # GET /companies/1/select
  def select
    session[:company] = @company.id
    redirect_to action: :index
  end

  private
    def set_company
      ActsAsTenant.without_tenant do
        @company = Company.find(params[:id])
      end
    end

    def company_params
      params.require(:company).permit(:name)
    end
end
