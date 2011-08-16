class PaginationListLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  protected
    
    def previous_or_next_page(page, text, classname)
      if text.eql? @options[:previous_label]
        icon = 'arrow-l'
        icon_pos = 'left'
      else
        icon = 'arrow-r'
        icon_pos = 'right'
      end

      if page
         link(text, page, 'data-role' => 'button', 'data-inline' => 'true', 'data-icon' => icon, 'data-iconpos' => icon_pos, 'data-theme' => 'b')
      else
        # something that doesn't look like a link
         tag(:span, text, 'data-role' => 'button', 'data-inline' => 'true', 'data-disabled' => 'true', 'data-theme' => 'a')
      end
    end
    
    def summary
      "#{@collection.current_page} of #{@collection.total_pages}"
    end
    
    def pagination
      [ :previous_page, :summary, :next_page ]
    end

end