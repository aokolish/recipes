module ApplicationHelper
  def sortable(column, title)
    if column == 'best_match'
      css_class = "current" if params[:sort] == nil
      link_to title, {:search => params[:search]}, {:class => css_class}
    else
      css_class = "current #{sort_direction}" if column == sort_column
      direction = sort_direction == "asc" ? "desc" : "asc"
      search_params = {:sort => column, :direction => direction, :search => params[:search]}
      link_to title, search_params, {:class => css_class}
    end
  end
end
