class ClaimsController < ApplicationController
  before_action :logged_in_user
  before_action :set_claim, only: [:show, :edit, :update, :destroy]
  before_action :set_solution, only: [:show, :edit, :update]

  # GET /claims
  # GET /claims.json
  def index
    # Pagination verwenden. Die Anzahl der Einträge pro Seite wird im Model verwaltet
    @claims = Claim.paginate(page: params[:page])
  end

  # GET /claims/1
  # GET /claims/1.json
  def show
  end

  # GET /claims/new
  def new
    @claim = Claim.new
  end

  # GET /claims/1/edit
  def edit
  end

  # Creates a new claim
  # the current user is stored with the object
  def create
    @claim = Claim.new(claim_params)
    @claim.set_insert_user(current_user) #User ID im Claim setzen

    if @claim.save
      flash[:success] = "Claim wurde erfolgreich erzeugt."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Speichern des Claims."
      render 'new'
    end
  end

  # Updating the current claim record
  def update

    @claim.set_update_user(current_user)
    if @claim.update(claim_params)
      flash[:success] = "Änderungen wurden erfolgreich gespeichert."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Aktualisieren des Claims."
      render 'edit'
    end
  end

  # DELETE /claims/1
  # DELETE /claims/1.json
  def destroy
    @claim.destroy
    flash[:success] = "Claim wurde erfolgreich gelöscht."
    redirect_to claims_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_claim
      @claim = Claim.find(params[:id])
    end

    # Sets the claim's solution, if it has one
    def set_solution
      if(@claim.has_solution?)
        @solution = Solution.find_by_id(@claim.solution)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:description, :claim_type_id)
    end
end
