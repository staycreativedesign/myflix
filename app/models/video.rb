# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  description     :text
#  small_cover_url :string(255)
#  large_cover_url :string(255)
#  category_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  validates :title, :description, presence: true
  has_many :queue_items

  delegate :name, :to => :category, :prefix => :category

  def self.search_by_title(search_term)
  	return [] if search_term.blank?
	  where("title ILIKE ?", "%#{search_term}%").order("created_at ASC")
  end
end
