require 'spec_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  #let(:recipe) { FactoryGirl.build(:recipe) }

  include CarrierWave::Test::Matchers

  before do
    AvatarUploader.enable_processing = true
    @user = User.new
    @uploader = AvatarUploader.new(@user, :avatar)
    @uploader.store!(File.open("public/images/test/chicken.jpg"))
  end

  after do
    AvatarUploader.enable_processing = false
    @uploader.remove!
  end

  describe "#default_url" do
    it "is returns a generic one" do
      @uploader.default_url.should eq "/images/fallback/avatar_default.jpg"
    end

    context "when a specific size is requested" do
      before { @uploader.stub(:version_name => 'micro') }

      it "returns a default for that size" do
        @uploader.default_url.should eq "/images/fallback/avatar_micro_default.jpg"
      end
    end
  end

  context 'the micro version' do
    it "should scale down a portrait image to be exactly 80 by 80 pixels" do
      @uploader.micro.should have_dimensions(50, 50)
    end
  end

  context 'the medium version' do
    it "should scale down a portrait image to fit within 210 by 210 pixels" do
      @uploader.medium.should have_dimensions(210, 210)
    end
  end

  context 'the large version' do
    it "should scale down a portrait image to fit within 700 by 700 pixels" do
      @uploader.large.should be_no_larger_than(700, 700)
    end
  end
end
