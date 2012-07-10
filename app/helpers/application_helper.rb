module ApplicationHelper
  def sortable(column, title=nil)
    title ||= column.titleize
    if column == 'best_match' # not a real column
      css_class = "current" if params[:sort] == nil
      link_to title, {:search => params[:search]}, {:class => css_class}
    else
      current_direction = sort_direction
      css_class = "current #{current_direction}" if column == sort_column
      new_direction = current_direction == "asc" ? "desc" : "asc"
      search_params = {:sort => column, :direction => new_direction, :search => params[:search]}
      link_to title, search_params, {:class => css_class}
    end
  end

  def twitterized_type(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end

end
