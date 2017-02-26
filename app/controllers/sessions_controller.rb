class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.finb_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to posts_path, notice: 'Logged In'
    else
      flash[:alert] = "Wrong email or password"
      render :new
    end
  end

end
