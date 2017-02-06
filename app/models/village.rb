class Village < ActiveRecord::Base

  validates :code, presence: true
  validates :code, uniqueness: true

end