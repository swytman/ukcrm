class Tariff < ActiveRecord::Base
  belongs_to :counter, class_name: 'Counter', primary_key: 'code', foreign_key: 'counter_code'

  def self.by_code(code)
    where(counter_code: code)
  end

  def date
    DateTime.new(year,month).strftime("%m.%Y")
  end

end