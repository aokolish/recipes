module ReviewHelper
  def rating_stars(rating)
    (1..5).inject('') do |memo, i|
      memo += content_tag(:span) do
        css = ''
        if rating > 0
          if rating < 1
            css = '-half'
          end
        else
          css = '-empty'
        end
        rating -= 1
        content_tag(:i, nil, class: "icon-star#{css}")
      end
    end.html_safe
  end
end
