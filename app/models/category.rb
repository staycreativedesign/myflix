# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at ASC")}
  validates :name, presence: true
  def recent_videos
  	videos.first(6)
  end
end
