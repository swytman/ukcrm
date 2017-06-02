class Property < ActiveRecord::Base

  PROPERTY_TYPES = ['таунхаус', 'дуплекс', 'коттедж']

  belongs_to :user
  belongs_to :village
  has_many :meterings, inverse_of: :property

  validates :title, presence: true

end