# == Schema Information
#
# Table name: queue_items
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  video_id   :integer
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

class QueueItem < ActiveRecord::Base
	belongs_to :user
	belongs_to :video
	validates_numericality_of :position, only_integer: true
	delegate :full_name, :to => :user, :prefix => :user
	delegate :title, :to => :video, :prefix => :video
	delegate :category_name, :to => :video

	def rating
		review.rating if review
	end

	def rating=(new_rating)
		if review
			review.update_column(:rating, new_rating)
		else
			review = Review.create(user: user, video: video, rating: new_rating)
			review.save(validate: false)
		end
	end

	private

	def review
		@review ||= Review.where(user_id: user.id, video_id: video.id).first	
	end
	
end
