class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable,
         :recoverable, :rememberable, :trackable

  def full_name_with_email
    if full_name.present? && email.present?
      "#{full_name} (#{email})"
    elsif full_name.present? && !email.present?
      "#{full_name}"
    elsif !full_name.present? && email.present?
      "#{email}"
    else
      'No name!'
    end
  end

  def full_name
    title
  end

  def last_admin?
    all_admitistrators = Group.administrators.users
    all_admitistrators.count == 1 && self.id == all_admitistrators.first.id
  end

  def is?(*roles)
    @group_ids ||= self.role_ids + self.groups.map { |g| g.role_ids }.flatten

    roles.flatten.each do |role|
      unless role.is_a? Role
        role = Role.find_by_title(role.to_s)
      end
      return true if role && @group_ids.include?(role.id)
    end
    false
  end


end
