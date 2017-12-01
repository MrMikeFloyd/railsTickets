class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Benutzerkonto wurde noch nicht aktiviert. "
        message += "Bitte aktivieren Sie zunächst Ihr Konto mithilfe der Aktivierungsmail."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Benutzername oder Passwort ungültig!' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end