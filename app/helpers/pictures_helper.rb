module PicturesHelper
  def edit_caption
    # put this in as a helper because it needs to passed into a large hash
    content_tag :p, :class => "placeholder" do
      content_tag(:span,'Add a caption') +
      content_tag(:a, :class => 'add-caption btn btn-success') do
        content_tag(:i,'', :class => 'icon-pencil')
      end
    end
  end
end
