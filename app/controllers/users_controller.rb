class UsersController < ApplicationController

	def new
		@user = User.new		
	end
	def create
		@user = User.create(user_params)
		binding.pry
		if @user.save
			redirect_to sign_in_path
		else
			render :new
		end
	end

private
	
	def user_params
		params.require(:user).permit(:full_name, :email, :password)
	end

end