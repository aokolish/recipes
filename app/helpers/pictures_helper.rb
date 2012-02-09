module PicturesHelper
  def edit_caption
    # put this in as a helper because it needs to passed into a large hash
    content_tag :p, :class => "placeholder" do
      content_tag(:span,'Add a caption') +
      content_tag(:span,'p', :class => 'edit-button')
    end
  end
end
