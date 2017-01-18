class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable,
         :recoverable, :rememberable, :trackable

  def full_name_with_email
    if title.present? && email.present?
      "#{title} (#{email})"
    elsif title.present? && !email.present?
      "#{title}"
    elsif !title.present? && email.present?
      "#{email}"
    else
      'No name!'
    end
  end
end
