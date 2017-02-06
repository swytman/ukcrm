class VillageLinks < ActiveRecord::Migration
  def change
    add_column :tariffs, :village_code, :string
    add_column :counters, :village_code, :string

    Rake::Task['villages:init_village'].invoke


  end
end
