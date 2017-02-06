namespace :villages do

  desc 'Create administrator account'
  task :init_village => :environment do
    unless default = Village.find_by(code: 'NEWBAKEEVO')
      default = Village.new(title: 'Новое Бакеево', code: 'NEWBAKEEVO')
      default.save
    end

    Tariff.all.update_all(village_code: 'NEWBAKEEVO')
    Counter.all.update_all(village_code: 'NEWBAKEEVO')

    puts "Create default villages"
  end
end