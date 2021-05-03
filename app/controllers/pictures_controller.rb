class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = current_user.pictures.build
    end
  end

  def index
    @pictures = Picture.all
  end

   def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to picture_path, notice: "You've posted!"
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture page was updated!' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invaild?
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: "You have deleted it" }
      format.json { head :no_content }
    end
  end

private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_correct_user
    @picture = Picture.find(params[:id])
    if @picture.user_id != current_user.id
      flash[:notice] = "No authority"
      redirect_to pictures_url
    end
  end

  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache)
  end
end

