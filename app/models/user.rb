class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_profile
  accepts_nested_attributes_for :user_profile, reject_if: :all_blank, update_only: true

  #Validations
  validates :first_name, presence: true, length: {minimum: 3}, on: :update, unless: :reset_password_token_present?

   #Virtual Atributes
  def full_name
    [self.first_name, self.last_name].join(' ')
  end

  #Callbacks
  after_create :set_statistic

  private
  def reset_password_token_present?
    !!$global_params[:user][:reset_password_token]
  end

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_users])
  end 
end
