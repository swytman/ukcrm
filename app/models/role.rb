class Role < ActiveRecord::Base
  SYSTEM_ROLES = [:administrator]

  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups

  validates :title, uniqueness: true
  validates :title, uniqueness: true

  def translated_title
    I18n.t("wrappers.Role.title.#{title}")
  end

  def all_users
    (users + groups.map(&:users).flatten).uniq
  end

  def self.find_by_title(title)
    @roles ||= Role.all.index_by(&:title)
    @roles[title]
  end
end
