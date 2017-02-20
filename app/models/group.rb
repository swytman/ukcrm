class Group < ActiveRecord::Base
  SYSTEM_GROUPS = [:administrators, :managers]

  has_and_belongs_to_many :users
  has_and_belongs_to_many :roles

  def is?(*roles)
    roles.flatten.each do |role|
      unless role.is_a? Role
        role = Role.find_by(title: role.to_s)
      end
      return true if role && role_ids.include?(role.id)
    end
    false
  end

  def pretty_title
    system? ? "<b>#{title}</b>".html_safe : title
  end

  def sort_method; end

  def system?
    SYSTEM_GROUPS.include? key.try(:to_sym)
  end

  def self.not_system_groups
    Group.where.not(key: SYSTEM_GROUPS)
  end

  def self.system_groups
    Group.where(key: SYSTEM_GROUPS)
  end

  def admins_will_be_empty?(ids)
    return true unless is?(:administrator)
    ids.length == 1 ? false : true # проверяем не пришло ли [""]
  end
end
