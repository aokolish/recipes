class PicturesController < ApplicationController
  respond_to :html, :json
  expose(:imageable) { find_imageable }
  expose(:pictures) { imageable.pictures }
  expose(:picture)

  def index
  end

  def create
    picture.save
    respond_with(picture) do |format|
      format.html { redirect_to :back, :notice => "Image added!" }
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

  def sort
    params[:picture].each_with_index do |id, index|
      Picture.update_all({position: index+1}, {id: id})
    end
    render nothing: true
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
