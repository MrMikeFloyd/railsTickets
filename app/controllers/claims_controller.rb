class ClaimsController < ApplicationController
  before_action :logged_in_user
  before_action :set_claim, only: [:show, :edit, :update, :destroy]
  #before_action :set_insert_user, only: :create

  # GET /claims
  # GET /claims.json
  def index
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

  # POST /claims
  # POST /claims.json
  def create
    @claim = Claim.new(claim_params)
    @claim.set_insert_user(current_user) #User ID im Claim setzen

    if @claim.save
      flash[:success] = "Claim wurde erfolgreich erzeugt."
      redirect_to @claim
    else
      redirect_to root_url
    end
  end

  # PATCH/PUT /claims/1
  # PATCH/PUT /claims/1.json
  def update
    @claim.set_update_user(current_user)
    if @claim.update(claim_params)
      flash[:success] = "Änderungen wurden erfolgreich gespeichert."
      redirect_to @claim
    else
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def claim_params
      params.require(:claim).permit(:description)
    end
end
