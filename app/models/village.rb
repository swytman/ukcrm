class Village < ActiveRecord::Base

  validates :code, presence: true
  validates :code, uniqueness: true
  has_many :users, inverse_of: :village,  primary_key: 'code', foreign_key: 'village_code'

end