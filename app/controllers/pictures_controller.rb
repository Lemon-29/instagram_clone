class PicturesController < ApplicationController
  before_action :set_picture, only[:show, :edit, update, :destroy]

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = PictureBlog.new
    end
  end

   def create
    @picture= PictureBlog.new(picture_params)
    @picture.user_id = current_user.index
    if @picture.save
      PictureMailer,picture_mail(@picture_blog).deliver
      redirect_to picture_path, notice: "You've posted!"
    else
      render :new
    end
  end

  def update
    if @picture.update(picture_params)
      redirect_to picture_path, notice: "You've posted!"
    else
      render :new_session_path
    end
  end

  def index
    @pictre = PictureBlog.all
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_usesr.id
    render :new if @picture.invaild?
  end

  def destroy
    @picture.destroy
    redirect_to picture_path, notice: "You've delated it"
end

private

def picture_params
  params.require(:picture).permit(:title, :content, :image, :image_cache)
end

def set_picture
  @picture = Picture.find(params[:id])
end


