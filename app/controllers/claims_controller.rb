class ClaimsController < ApplicationController
  before_action :logged_in_user
  before_action :set_claim_in_session, only: :show # Aktuellen Claim in die Session schreiben, wenn wir einen bestimmten anzeigen
  before_action :set_claim, only: [:show, :edit, :update, :destroy, :finish, :reopen]
  before_action :set_solution, only: [:show, :edit, :update]
  before_action :set_update_user, only: [:update, :finish, :reopen]

  # Anzeige aller Claims
  def index
    # Pagination verwenden. Die Anzahl der Einträge pro Seite wird im Model verwaltet
    # Sortiere nach Status und Erstellungsdatum
    @claims = Claim.order(status: :asc, created_at: :desc).paginate(page: params[:page])
  end

  # Konkreten Claim anzeigen
  def show
  end

  # Neuerstellung eines Claims
  def new
    @claim = Claim.new
  end

  # Editieren eines Claims
  def edit
  end

  # Speicherung eines neuen Claims
  def create
    @claim = Claim.new(claim_params)
    @claim.init_defaults(current_user)

    if @claim.save
      flash[:success] = "Claim wurde erfolgreich erzeugt."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Speichern des Claims."
      render 'new'
    end
  end

  # Aktualisierung eines existenten Claims
  def update
    if @claim.update(claim_params)
      flash[:success] = "Änderungen wurden erfolgreich gespeichert."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Aktualisieren des Claims."
      render 'edit'
    end
  end

  # Löschen des Claims
  def destroy
    @claim.destroy
    flash[:success] = "Claim wurde erfolgreich gelöscht."
    redirect_to claims_url
  end

  # Claim-Abschluss
  def finish
    @claim.terminate
    if @claim.save
      flash[:success] = "Claim wurde erfolgreich abgeschlossen."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Aktualisieren des Claims."
      render 'edit'
    end
  end

  # Claim-Wiedereröffnung
  def reopen
    @claim.set_reopen
    if @claim.save
      flash[:success] = "Claim wurde erfolgreich wiedereröffnet."
      redirect_to @claim
    else
      flash.now[:danger] = "Fehler beim Aktualisieren des Claims."
      render 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Sets the current claim and defines the behaviour for forms
    def set_claim
      @claim = Claim.find(params[:id])
      define_form_behaviour(@claim)
    end

    # Writes this claim into the session
    def set_claim_in_session
      session[:claim] = params[:id]
    end

    # Setzt die Mailadresse des aktuellen Users.
    def set_update_user
      logger.info("Setting update user.")
      update_user = current_user
      @claim.update_user = update_user.email
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
