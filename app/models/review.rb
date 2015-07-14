class Review < ActiveRecord::Base
	belongs_to :video
	belongs_to :user
	validates :description, presence: true

	delegate :full_name, :to => :user, :prefix => :user

end