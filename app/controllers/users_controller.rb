class UsersController < ApplicationController

  def new
    @user = User.new    
  end
  def create
    user = User.create(user_params)
    if user.save
      redirect_to root_path
    else
      flash[:error] = 'You email or password does not match'
      render :new
    end
  end

private
  
  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end