namespace :users do
  desc "Update users information"
  task :update_default_password_all_users => :environment do |task|
    users = User.all
    users.each do |user|
      user.password = user.email
      user.save
    end
  end
end
