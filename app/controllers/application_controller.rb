class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Bitte anmelden."
        redirect_to login_url
      end
    end

    # Store the current claim in the session when a new picture is about to be added to it
    def set_claim_in_session
      unless params[:claim].nil?
        session[:claim] = params[:claim]
      else
        raise "Error: Unable to save the current event in the session as it's not embedded in the request."
      end
    end

    # Reads the current claim from the session, if it is set
    def get_current_claim
      unless session[:claim].nil?
        @current_claim = Claim.find(session[:claim])
      else
        raise "Error: Unable to return the current claim as it is not set in the session."
      end
    end

end