namespace :users do

  desc 'Create base groups'
  task :create_groups => :environment do
    Group.create(key: 'administrators', title: 'Администраторы') if Group.find_by(key: 'administrators').nil?
    Group.create(key: 'heads', title: 'Ведущие менеджеры') if Group.find_by(key: 'heads').nil?
    Group.create(key: 'managers', title: 'Mенеджеры') if Group.find_by(key: 'managers').nil?
    Group.create(key: 'correctors', title: 'Корректоры') if Group.find_by(key: 'correctors').nil?
    puts "Create base groups. Done!"
  end

  desc 'Create base roles'
  task :create_roles => :environment do
    ['administrator', 'head', 'manager', 'corrector', 'content_manager', 'seo'].each do |title|
      next unless Role.find_by(title: title).nil?
      role  = Role.create(title: title)
      group = Group.find_by(key: "#{title}s")
      group.roles << role if group
    end
    puts "Create base roles. Done!"
  end

  desc 'Create administrator account'
  task :create_admin => :environment do
    unless admin = User.find_by(email: 'stepanov.vm@gmail.com')
      admin = User.new(email: 'stepanov.vm@gmail.com', password: '123uk123', password_confirmation: '123uk123')
      admin.save!(validate: false)
    end
    #admin_role =  Role.find_by(title: 'administrator')
    #unless admin.role_ids.include? admin_role.id
    #  admin.roles << admin_role
    #  admin.save!(validate: false)
    #end
    puts "Create admin user. Done!"
  end

  desc 'Init = call all tasks'
  task :init do
    Rake::Task['users:create_groups'].execute
    Rake::Task['users:create_roles'].execute
    Rake::Task['users:create_admin'].execute
  end

end