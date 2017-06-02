class AddPropertiesTable < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.string :ptype
      t.integer :user_id
      t.integer :village_id
    end

    add_column :meterings, :property_id, :integer
  end
end
