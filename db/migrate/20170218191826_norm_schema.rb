class NormSchema < ActiveRecord::Migration
  def change
    add_column :tariffs, :counter_id, :integer

    Tariff.all.each do |t|
      counter = Counter.find_by(code: t.counter_code) if t.counter_code
      t.counter_id = counter.id if counter
      t.save
    end

  end
end
