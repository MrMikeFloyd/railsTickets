class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  #before_action :set_claim_in_session, only: :new

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
    @claim = get_current_claim
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @claim = get_current_claim
    @picture.claim = @claim

    if @picture.save
      flash[:success] = "Fotodatei wurde erfolgreich gespeichert."
      redirect_to get_current_claim
    else
      flash.now[:danger] = "Beim Speichern der Fotodatei ist ein Fehler aufgetreten."
      render 'new'
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    if @picture.update(picture_params)
      flash[:success] = "Fotodatei wurde erfolgreich aktualisiert."
      redirect_to get_current_claim
    else
      flash.now[:danger] = "Bei der Aktualisierung der Fotodatei ist ein Fehler aufgetreten."
      render 'edit'
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    flash[:success] = "Fotodatei wurde erfolgreich gelöscht."
    redirect_to get_current_claim
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:file, :description, :claim)
    end
end
