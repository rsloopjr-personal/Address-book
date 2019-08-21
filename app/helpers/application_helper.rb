module ApplicationHelper

  def current_class?(selected_id)
    if session[:contact_group_id] == selected_id
      return 'btn btn-block sidebar-button nav-link active'
    else
      return 'btn btn-block sidebar-button nav-link'
    end
  end
  
end
