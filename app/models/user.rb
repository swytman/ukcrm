class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :validatable,
         :recoverable, :rememberable, :trackable, :confirmable

  # virtual attribute to skip password validation while saving
  attr_accessor :skip_password_validation
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :groups
  belongs_to :village, class_name: 'Village', primary_key: 'code', foreign_key: 'village_code'
  has_many :meterings, inverse_of: :user

  validates :village_code, presence: true, if: Proc.new{ |a| a.is?(:settler) }

  # after_create :welcome_message

  def waiting_counters
    waiting_month = Helpers::Month.waiting_month
    result = {}
    send_required = false
    return false unless is?(:settler) || village.nil?
    counters = village.counters.where(:editable_by_settler => true)
    counters.each do |c|
      result[c.id] = c.meterings.where(user_id: id, month: waiting_month[:month], year: waiting_month[:year]).
          order('year DESC, month DESC').try(:first)
      send_required = true unless result[c.id].present?

    end
    if send_required
      result
    else
      false
    end
  end

  def current_month_counters
    waiting_month = Helpers::Month.waiting_month
    result = {}
    return false unless is?(:settler) || village.nil?
    counters = village.counters.where(:editable_by_settler => true)
    counters.each do |c|
      result[c.id] = c.meterings.where(user_id: id, month: waiting_month[:month], year: waiting_month[:year]).
          order('year DESC, month DESC').try(:first)
    end
    result
  end

  def users
    return User.all if is?(:administrator)
    return village.users if is?(:manager)
  end

  def groups_allowed_for_assign
    groups = []
    if is?(:administrator)
      groups = Group.all
    end
    if is?(:manager)
      groups = Group.not_system_groups
    end
    groups
  end

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

  # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def welcome_message
    UserMailer.welcome_message(self).deliver
  end

  def remind_to_send_counters(month)
    UserMailer.remind_to_send_counters(self, month).deliver
  end

  protected

  def password_required?
    return false if skip_password_validation
    super
  end



end
