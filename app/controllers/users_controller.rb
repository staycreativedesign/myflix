class UsersController < ApplicationController

	def new
		@user = User.new		
	end
	def create
		@user = User.create(params[user_params])
		binding.pry
		if @user.save
			redirect_to root_path
		else
			redirect_to register_path
		end
	end

private
	
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

end