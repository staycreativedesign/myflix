class QueueItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :video

	delegate :full_name, :to => :user, :prefix => :user
	delegate :title, :to => :video, :prefix => :video
	delegate :category_name, :to => :video

	def rating
		review = Review.where(user_id: user.id, video_id: video.id).first
		review.rating if review
	end
end