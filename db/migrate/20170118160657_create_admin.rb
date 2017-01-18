class CreateAdmin < ActiveRecord::Migration
  def change
    Rake::Task['users:create_admin'].invoke
  end
end
