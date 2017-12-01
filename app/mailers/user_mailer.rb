class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Aktivierung Ihres Benutzerkontos"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Rücksetzung Ihres Passworts"
  end
end
