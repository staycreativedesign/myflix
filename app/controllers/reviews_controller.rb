class ReviewsController < ApplicationController
  before_filter :require_user
  
  def create
    video = Video.find(params[:video_id])
    reviews = video.reviews
    review = video.reviews.create(review_params.merge(user: current_user))
    if review.save
      redirect_to video_path(video), notice: 'Review created'      
    else
      flash[:error] = review.errors.full_messages.to_sentence
      render "videos/show"
    end
  end

  private

  def user_already_gave_a_review?(review)
    reviews.map(&:user).include?(review)
  end

  def review_params
    params.require(:review).permit!
  end
end