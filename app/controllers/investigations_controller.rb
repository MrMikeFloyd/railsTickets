class InvestigationsController < ApplicationController
  before_action :set_investigation, only: [:show, :edit, :destroy]

  def show
    @resultData = @investigation.query_result
  end

  def new
    @investigation = Investigation.new
    @claim = get_current_claim
  end

  # Setzt die Abfrage ab und speichert diese mit dem Claim.
  def create
    @investigation = Investigation.new(investigation_params)
    @claim = get_current_claim
    @investigation.claim = @claim

    if @investigation.save
      flash[:success] = "Recherchedokument wurde erfolgreich gespeichert. Abfrage wird ausgeführt."
      @investigation.perform_query

      redirect_to get_current_claim
    else
      flash.now[:danger] = "Beim Speichern des Recherchedokuments ist ein Fehler aufgetreten."
      render 'new'
    end
  end

  def destroy
    @investigation.destroy
    flash[:success] = "Recherchedokument wurde erfolgreich gelöscht."
    redirect_to get_current_claim
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_investigation
    @investigation = Investigation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def investigation_params
    params.require(:investigation).permit(:query_param, :query_result)
  end
end
