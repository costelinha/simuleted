module ApplicationHelper
  def attribute_translation(object=nil, method=nil)
    (object && method) ? object.model.human_attribute_name(method) : "Error"
  end
end
