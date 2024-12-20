module ApplicationHelper
  def current_company
    session[:company] ||= Company.first.id
    Company.find(session[:company])
  end

  def currencies
    Currency.all.pluck(:iso)
  end

  def inline_error_for(field, form_obj)
    html = []
    if form_obj.errors[field].any?
      html << form_obj.errors[field].map do |msg|
        tag.div(msg, class: "text-red-400 text-xs m-0 p-0 text-right mb-2")
      end
    end
    html.join.html_safe
  end

  def signedin?
    !!Current.user
  end
end
