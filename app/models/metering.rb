class Metering < ActiveRecord::Base
  belongs_to :tariff
  has_one :counter, through: :tariff
end