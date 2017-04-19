module ApplicationHelper
  def left_menu_active_class(current_page)
    if controller.controller_name == current_page
      "active"
    end
  end

  def br(str)
    #タグ(<b></b>)エスケープ後改行コードをbrタグに変換してエスケープしない
    html_escape(str).gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
end
