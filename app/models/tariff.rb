class Tariff < ActiveRecord::Base
  belongs_to :counter, class_name: 'Counter', primary_key: 'code', foreign_key: 'counter_code'
  has_one :village, through: :counter

  validates :rate, presence: true

  def self.by_code(code)
    where(counter_code: code).order('year DESC, month DESC')
  end

  def self.current(code)
    by_code(code).first
  end

  def date
    DateTime.new(year,month).strftime("%m.%Y")
  end

  def full_title
    "#{rate} от #{date}"
  end

end