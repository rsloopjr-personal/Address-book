module ApplicationHelper

  def current_class?(selected_id, search_groups_ids)
    if search_groups_ids.blank?
    
      if session[:contact_group_id] == selected_id
        return 'btn btn-block sidebar-button nav-link active'
      else
        return 'btn btn-block sidebar-button nav-link'
      end
    else
      if search_groups_ids.include? selected_id
        return 'btn btn-block sidebar-button nav-link active'
      else
        return 'btn btn-block sidebar-button nav-link'
      end
    end
  end
  
end
