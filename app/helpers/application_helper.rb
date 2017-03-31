module ApplicationHelper
  def left_menu_active_class(current_page)
    if controller.controller_name == current_page
      'active'
    end
  end
end
