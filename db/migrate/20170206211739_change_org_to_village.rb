class ChangeOrgToVillage < ActiveRecord::Migration
  def change
    rename_column :users, :organization_code, :village_code
    remove_column :counters, :organization_code
    drop_table :organizations
  end
end
