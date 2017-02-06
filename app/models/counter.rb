class Counter < ActiveRecord::Base
  belongs_to :village, class_name: 'Village', primary_key: 'code', foreign_key: 'village_code'
  validates :code, presence: true
  validates :code, uniqueness: true


end