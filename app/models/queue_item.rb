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
		review = Review.where(user_id: user.id, video_id: video.id).first
		review.rating if review
	end

	def rating=(new_rating)
		review = Review.where(user_id: user.id, video_id: video.id).first
		review.update_column(:rating, new_rating)
	end
	
end
