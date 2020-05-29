namespace :dev do
  PASS = 123456
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner() { %x(rails db:drop db:create db:migrate dev:add_admins dev:add_users) }  
    end
  end

  desc "Popula o banco com administradores"
  task add_admins: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: PASS,
    password_confirmation: PASS
    )
    
    10.times do |i|
      Admin.create!(
      email: Faker::Internet.email,
      password: PASS,
      password_confirmation: PASS
      )
    end
  end

  desc "Popula o banco como usuários"
  task add_users: :environment do
    User.create!(
    email: 'user@user.com',
    password: PASS,
    password_confirmation: PASS
    )

    10.times do |i|
      User.create!(
      email: Faker::Internet.email,
      password: PASS,
      password_confirmation: PASS
      )
    end
  end

  private
  def show_spinner()
    spinner = TTY::Spinner.new("[:spinner] Loading tasks...")
    spinner.auto_spin
    yield
    spinner.success('Done!')    
  end
end
