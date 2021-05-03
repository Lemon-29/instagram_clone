class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
 
  def new
    @users = User.new
  end

  def index
    @user = User.all

  def create
    @user = User.new(usesrs_params)
    if @user.save
      session[:users_id] = @user.id
      redirect_to user_path(@user.id), notice: "Created account!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You've updated your profile!"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params)[:id]
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end

