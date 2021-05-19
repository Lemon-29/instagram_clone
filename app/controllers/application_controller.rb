class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def login_required
    unless current_user
      flash[:notice] = "先にログインしてください"
      redirect_to new_session_path
    end
  end
end
