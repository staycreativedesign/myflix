class Category < ActiveRecord::Base
  has_many :videos, -> { order("created_at ASC")}

  def recent_videos
  	videos.first(6)
  end
end
