class ReviewsController < ApplicationController
	before_filter :require_user
	
	def create
		@video = Video.find(params[:video_id])
		@review = @video.reviews.create(review_params.merge(user: current_user))
		if @review.save
			redirect_to video_path(@video), notice: 'Review created'
		else
			flash[:error] = 'Review not created missing description.'
			render "videos/show"
		end
	end

	private

	def review_params
		params.require(:review).permit!
	end
end