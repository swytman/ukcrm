class AddOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string 'title'
      t.string 'code'
      t.timestamps
    end

    add_column :counters, :organization_code, :string

  end
end
