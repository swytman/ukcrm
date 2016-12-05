class CreateCounter < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.string 'title'
      t.string 'code'
      t.string 'color'
      t.float 'rate'
    end

    create_table :tariffs do |t|
      t.float 'rate'
      t.integer 'month'
      t.integer 'year'
      t.integer 'counter_code'
    end

    create_table :meterings do |t|
      t.integer 'value'
      t.integer 'tariff_id'
    end

  end
end
