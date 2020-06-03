class Site::SearchController < SiteController
  def questions
    @questions = Question._search(params[:term], params[:page])
  end
end
