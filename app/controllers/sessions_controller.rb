class SessionsController < ApplicationController
	def create
		user = User.where(email: params[:email]).first
		binding.pry
		if user && user.authenticate(params[:password])
			binding.pry
			session[:user_id] = user.id
			redirect_to home_path, notice: 'You are signed in, enjoy'
		else
			flash[:error] = 'You email or password does not match'
			redirect_to sign_in_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "You signed out."
	end

end