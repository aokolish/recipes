require 'spec_helper'

describe PicturesHelper do
  describe "#edit_caption" do
    it "returns html for an edit caption" do
      helper.edit_caption.should eq('<p class="placeholder"><span>Add a caption</span><a class="add-caption btn btn-success"><i class="icon-pencil"></i></a></p>')
    end
  end
end

