class User < ActiveRecord::Base
	has_secure_password validations: false
	validates :email, :full_name, :password, presence: true
	validates_uniqueness_of :email
end