class Review < ActiveRecord::Base
	belongs_to :video
	belongs_to :user
	validates :description, presence: true
end