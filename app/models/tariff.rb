class Tariff < ActiveRecord::Base
  belongs_to :counter, class_name: 'Counter', primary_key: 'code', foreign_key: 'counter_code'

end