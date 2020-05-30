namespace :dev do

  DEFAULT_PASS = 123456
  DEFAULT_PATH = File.join(Rails.root, 'lib', 'tmp')
  
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner() { %x(rails db:drop db:create db:migrate dev:add_admins dev:add_users dev:add_subjects) }  
    end
  end

  desc "Popula o banco com administradores"
  task add_admins: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: DEFAULT_PASS,
    password_confirmation: DEFAULT_PASS
    )
    
    10.times do |i|
      Admin.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASS,
      password_confirmation: DEFAULT_PASS
      )
    end
  end

  desc "Popula o banco com usuários"
  task add_users: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASS,
    password_confirmation: DEFAULT_PASS
    )

    10.times do |i|
      User.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASS,
      password_confirmation: DEFAULT_PASS
      )
    end
  end

  desc "Popula o banco com assuntos(subjects)"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_PATH, file_name)
    
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip())
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
