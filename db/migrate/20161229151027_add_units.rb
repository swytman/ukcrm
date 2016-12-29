class AddUnits < ActiveRecord::Migration
  def change
    add_column :counters, :unit, :string, :default => ''
  end
end
