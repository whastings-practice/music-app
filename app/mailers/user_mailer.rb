class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activation_email(user)
    @activation_url = activate_users_url(
      activation_token: user.activation_token
    )
    mail(to: user.email, subject: 'Activate Your Music App Account')
  end
end
