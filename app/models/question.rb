class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true 

  #Kaminari (pagination)
  paginates_per 5

  #Scopes
  scope :_search, ->(term, page) {
    includes(:answers, :subject)
    .where("lower(description) LIKE ?", "%#{term.to_s.downcase}%")
    .page page
  }

  scope :_search_subject, ->(page, subject_id) {
    includes(:answers, :subject)
    .where(subject_id: subject_id)
    .page page
  }

  scope :last_questions, ->(page){
    includes(:answers, :subject).order("id desc").page page
  }

  #Callbacks
  after_create :set_statistic

  private
  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end 
end
