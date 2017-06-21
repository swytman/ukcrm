namespace :properties do
  desc 'Create base groups'
  task move_meterings: :environment do
    Metering.all.each do |m|
      m.property = m.user.properties.first if m.user && !m.property
      m.save
    end
  end
end