class Counter < ActiveRecord::Base
  belongs_to :village, class_name: 'Village', primary_key: 'code', foreign_key: 'village_code'
  has_many :tariffs, inverse_of: :counter
  has_many :meterings, through: :tariffs

  validates :code, presence: true
  validates :code, uniqueness: { scope: :village_code,
      message: "такой код уже существует" }

  validates :village_code, presence: true
  validates :title, presence: true

  scope :editable_by_settler, -> () { where(:editable_by_settler => true) }


  def current_tariff
    tariffs.order('year DESC, month DESC').first
  end

  def editable_by_user?(user)
    user.is?(:manager, :administrator) || editable_by_settler
  end

  def tariff_for_month(month, year)
    list = tariffs.order('year DESC, month DESC').to_a
    list.each_with_index do |t, i|
      compare_res = Helpers::Month.compare({month: month, year: year}, {month: t.month, year: t.year})

      if compare_res == 0
        return t
      end

      if compare_res == 1
        return list[i]
      end

    end
    return list.last
  end


end