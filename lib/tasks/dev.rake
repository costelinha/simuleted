namespace :dev do
  PASS = 123456
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner() { %x(rails db:drop db:create db:migrate dev:add_default_admin dev:add_default_user) }  
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
    email: 'admin@admin.com',
    password: PASS,
    password_confirmation: PASS
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: PASS,
    password_confirmation: PASS
    )
  end

  private
  def show_spinner()
    spinner = TTY::Spinner.new("[:spinner] Loading tasks...")
    spinner.auto_spin
    yield
    spinner.success('Done!')    
  end
end
