class Counter < ActiveRecord::Base
  belongs_to :village, class_name: 'Village', primary_key: 'code', foreign_key: 'village_code'
  has_many :tariffs, inverse_of: :counter
  has_many :meterings, through: :tariffs

  validates :code, presence: true
  validates :code, uniqueness: { scope: :village_code,
      message: "такой код уже существует" }

  validates :village_code, presence: true
  validates :title, presence: true


  def current_tariff
    tariffs.order('year DESC, month DESC').first
  end

end