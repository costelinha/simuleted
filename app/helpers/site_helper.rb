module SiteHelper
  def msg_jumbotron
   case params[:action]
   when 'index'
    'Welcome'
   when 'questions'
    "\"#{params[:term]}\" results"
   when 'subject'
    " Subject \"#{params[:subject]}\""
   end
  end
end
