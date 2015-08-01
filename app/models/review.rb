# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  description :text
#  video_id    :integer
#  rating      :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates_presence_of :description
  validates_uniqueness_of :user_id, scope: :video_id
  delegate :full_name, :to => :user, :prefix => :user, :allow_nil => true

end
