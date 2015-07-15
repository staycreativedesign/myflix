class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :description, message: "is blank. Please fill out the description"
  validates_uniqueness_of :user_id, scope: :video_id, message: "Sorry, you have already reviewed this title."
  delegate :full_name, :to => :user, :prefix => :user, :allow_nil => true

end