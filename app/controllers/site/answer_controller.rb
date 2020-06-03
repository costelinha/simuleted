class Site::AnswerController < SiteController
  def question
    puts ("--> ID: #{params[:answer]} ")
  end
end
