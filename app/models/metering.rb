class Metering < ActiveRecord::Base
  belongs_to :tariff
  has_one :counter, through: :tariff

  def self.by_code(code)
    joins(:tariff).where(tariffs: {counter_code: code}).order('year DESC, month DESC')
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