class MigrateMyData < ActiveRecord::Migration
  def change
    @user = User.new({title: '58-3', email: 'ravensl@mail.ru'})
    @item.skip_password_validation = true
    @user.save
    @village = Village.last

    Counter.all.update_all({village_code: @village.code})

    Tariff.all.each do |t|
      counter = Counter.find_by(code: t.counter_code)
      t.counter_id = counter.id if counter
      t.save
    end

    Metering.update_all({user_id: @user.id})


  end
end
