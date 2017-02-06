class AddVillage < ActiveRecord::Migration
  def change
    create_table :villages do |t|
      t.string 'title'
      t.string 'code'
    end



  end
end
