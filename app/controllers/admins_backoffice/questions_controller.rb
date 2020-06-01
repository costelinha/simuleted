class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :get_subjects, only: [:edit, :new]

  def index
    @questions = Question.all.order(:description).page params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question)
    if @question.save()
      redirect_to admins_backoffice_questions_path, notice: "Question created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(params_question)
      redirect_to admins_backoffice_questions_path, notice: "Question updated successfully"
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy()
      redirect_to admins_backoffice_questions_path, notice: "Question deleted successfully"
    else
      render :index
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def get_subjects
    @subjects = Subject.all
  end

  def params_question
    params_question = params.require(:question).permit(:description, :subject_id)
  end
end
