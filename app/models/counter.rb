class Counter < ActiveRecord::Base
  belongs_to :village, class_name: 'Village', primary_key: 'code', foreign_key: 'village_code'

  validates :code, presence: true
  validates :code, uniqueness: { scope: :village_code,
      message: "такой код уже существует" }

  validates :village_code, presence: true
  validates :title, presence: true


  def build_full_code


  end

end