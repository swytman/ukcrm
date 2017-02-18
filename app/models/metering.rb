class Metering < ActiveRecord::Base
  belongs_to :tariff
  belongs_to :user
  has_one :counter, through: :tariff

  validates :value, presence: true

  def self.by_code(code)
    joins(:tariff => :counter).where(counters: {code: code}).order('year DESC, month DESC')
  end

  def date
    DateTime.new(year,month).strftime("%m.%Y")
  end

  def code
    tariff.counter_code
  end

  def total
    res = 0
    res = value * tariff.rate if value && tariff.rate
    res
  end

end