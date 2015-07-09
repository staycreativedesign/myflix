class ReviewsController < ApplicationController

	def create
		@video = Video.find(params[:video_id])
		@review = @video.reviews.create(review_params)
		if @review.save
			redirect_to video_path(@video), notice: 'Review created'
		else
			flash[:error] = 'Review not created missing description.'
			redirect_to video_path(@video)
		end
	end

	private

	def review_params
		params.require(:review).permit!
	end
end