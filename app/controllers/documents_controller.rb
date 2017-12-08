class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  #before_action :set_claim_in_session, only: :new

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
    @claim = get_current_claim
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.claim = get_current_claim

    if @document.save
      flash[:success] = "Dokumentendatei wurde erfolgreich gespeichert."
      redirect_to get_current_claim
    else
      flash.now[:danger] = "Beim Speichern der Dokumentendatei ist ein Fehler aufgetreten."
      render 'new'
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    if @document.update(document_params)
      flash[:success] = "Dokumentendatei wurde erfolgreich aktualisiert."
      redirect_to get_current_claim
    else
      flash.now[:danger] = "Bei der Aktualisierung der Dokumentendatei ist ein Fehler aufgetreten."
      render 'edit'
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    flash[:success] = "Dokumentendatei wurde erfolgreich gelöscht."
    redirect_to get_current_claim
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:file, :description)
    end
end
