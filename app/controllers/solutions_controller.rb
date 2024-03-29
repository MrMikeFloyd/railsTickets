class SolutionsController < ApplicationController
  before_action :set_solution, only: [:show, :edit, :update, :destroy]
  #before_action :set_claim_in_session, only: :new
  before_action :set_claim, only: [:show, :new, :create, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @solutions = Solution.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @solution = Solution.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @solution = Solution.new(solution_params)
    @solution.claim = @claim

    if @solution.save
      flash[:success] = "Lösungsdokument wurde erfolgreich gespeichert."
      redirect_to @claim
    else
      flash.now[:danger] = "Beim Speichern des Lösungsdokuments ist ein Fehler aufgetreten."
      render 'new'
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    if @solution.update(solution_params)
      flash[:success] = "Lösungsdokument wurde erfolgreich aktualisiert."
      redirect_to @claim
    else
      flash.now[:danger] = "Bei der Aktualisierung des Lösungsdokuments ist ein Fehler aufgetreten."
      render 'edit'
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @solution.destroy
    flash[:success] = "Lösungsdokument wurde erfolgreich gelöscht."
    redirect_to @claim
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_solution
    @solution = Solution.find(params[:id])
  end

  # Setzt den zugeordneten Claim und definiert das Verhalten von Formularen
  def set_claim
    @claim = get_current_claim
    define_form_behaviour(@claim)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def solution_params
    params.require(:solution).permit(:pid_info, :load_id, :description)
  end

end
