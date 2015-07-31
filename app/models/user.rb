class User < ActiveRecord::Base
	has_secure_password
	validates :email, :full_name, :password, presence: true
	validates_uniqueness_of :email
			
	has_many :queue_items, -> { order "position" }

	def normalize_queue_positions
	  queue_items.each_with_index do |queue_item, index|
	    queue_item.update_attributes(position: index+1)
	  end
	end

	def new_queue_item_position
	  queue_items.count + 1
	end
end