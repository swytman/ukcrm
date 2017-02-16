class SomeChanges < ActiveRecord::Migration
  def change
    remove_column :tariffs, :village_code
    add_column :meterings, :user_id, :integer
  end
end
