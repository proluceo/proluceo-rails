class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy]

  # GET /documents
  def index
    @documents = Document.companys.where(processed: false)
  end

  # GET /documents/1
  def show
    send_data @document.attachment_blob, filename: "document-#{@document.id}.pdf", type: "application/pdf", disposition: :inline
  end

  # GET /documents/new
  def new
    @document = Document.new
  end


  # POST /documents
  def create
    @document = Document.new(document_params)
    begin
      if @document.save
        render json: { result: :ok }, status: :created
      else
        render json: { error: "An error occured while uploading this file. Please try to upload it again." }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: "This file was already uploaded." }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.permit(:file, :authenticity_token).except(:authenticity_token)
  end

  include CompanyDependent
end
