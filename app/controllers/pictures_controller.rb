class PicturesController < ApplicationController
  respond_to :html, :json
  expose(:imageable) { find_imageable }
  expose(:pictures) { imageable.pictures }
  expose(:picture)

  def index
  end

  def create
    @picture = imageable.pictures.build(params[:picture])
    if @picture.save
      redirect_to :id => nil, :notice => "Successfully added image!"
    else
      redirect_to :back, :error => "There was a problem"
    end
  end

  def update
    picture.save
    respond_with picture
  end

  def destroy
    picture.destroy
    redirect_to :back, :notice => "Removed image."
  end

private

  def find_imageable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
