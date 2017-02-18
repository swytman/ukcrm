class Tariff < ActiveRecord::Base
  belongs_to :counter
  has_one :village, through: :counter
  has_many :meterings, inverse_of: :tariff

  validates :rate, presence: true

  def date
    DateTime.new(year,month).strftime("%m.%Y")
  end

  def full_title
    "#{rate} от #{date}"
  end

end