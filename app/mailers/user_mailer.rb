class UserMailer < ActionMailer::Base
  default :from => "myvillagemailer@gmail.com"

  def welcome_message(user)
    @user = user
    mail(:to => "#{user.title} <#{user.email}>", :subject => "Привет!")
  end

  def remind_to_send_counters(user, month)
    @user = user
    @month = I18n.t("date.one_month_names")[month]
    mail(:to => "#{user.title} <#{user.email}>", :subject => "Просьба заполнить показания счетчиков за #{@month}")
  end

end