module RecipesHelper
  def timestamp(date)
    content_tag(:i, "Added #{time_ago_in_words date} ago")
  end
end
