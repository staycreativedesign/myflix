class UsersController < ApplicationController

	def new
		@user = User.new		
	end
	def create
		binding.pry
		@user = User.create(params[:user])
		if @user.save
			redirect_to root_path
		else
			redirect_to register_path
		end
	end

end