class UserMailer < ApplicationMailer
  default from: '99cats@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'localhost:3000'
    mail(to: @user.username, subject: 'Welcome to 99 cats!')
  end
end
