class FavoritesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @favorites = current_user.favorite.all
  end
  
  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to picture_path, notice: "Added #{favorite.picture.user.name}" 's picture to your favorite"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to picture_path, notice: "Removed #{favorite.picture.user.name}'s favorite"
  end
end
