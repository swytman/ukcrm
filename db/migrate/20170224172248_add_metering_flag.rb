class AddMeteringFlag < ActiveRecord::Migration
  def change
    add_column :counters, :editable_by_settler, :boolean, :default => true
  end
end
