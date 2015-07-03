class StaticController < ApplicationController
	def main
		redirect_to home_path if current_user
	end 

end