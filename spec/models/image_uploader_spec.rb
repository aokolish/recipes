require 'spec_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  let(:recipe) { FactoryGirl.build(:recipe) }

  include CarrierWave::Test::Matchers

  before do
    ImageUploader.enable_processing = true
    @uploader = ImageUploader.new(recipe, :thumb)
    @uploader.store!(File.open("public/images/test/chicken.jpg"))
  end

  after do
    ImageUploader.enable_processing = false
    @uploader.remove!
  end

  describe "#default_url" do
    it "is returns a generic one" do
      @uploader.default_url.should eq "/images/fallback/default.jpg"
    end

    context "when a specific size is requested" do
      before { @uploader.stub(:version_name => 'thumb') }

      it "returns a default for that size" do
        @uploader.default_url.should eq "/images/fallback/thumb_default.jpg"
      end
    end
  end

  context 'the thumb version' do
    it "should scale down a portrait image to be exactly 80 by 80 pixels" do
      @uploader.thumb.should have_dimensions(80, 80)
    end
  end

  context 'the small version' do
    it "should scale down a portrait image to fit within 210 by 210 pixels" do
      @uploader.small.should have_dimensions(210, 210)
    end
  end

  context 'the large version' do
    it "should scale down a portrait image to fit within 700 by 700 pixels" do
      @uploader.large.should be_no_larger_than(700, 700)
    end
  end

  # I do not understand this, but I should investigate it
  #it "should make the image readable only to the owner and not executable" do
  #  @uploader.should have_permissions(0600)
  #end
end
