class User < ActiveRecord::Base
	validates :email, :full_name, :password, presence: true
end