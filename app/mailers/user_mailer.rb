class UserMailer < ActionMailer::Base
  default :from => "myvillagemailer@gmail.com"

  def welcome_message(user)
    @user = user
    mail(:to => "#{user.title} <#{user.email}>", :subject => "Привет!")
  end

end