require 'spec_helper'

describe User do
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should validate_presence_of(:full_name) }
	it { should validate_uniqueness_of(:email) }
	it { should have_many(:queue_items).order('position') }

	describe "#queued_video?" do
		let(:user) {Fabricate(:user)}
		let(:video) {Fabricate(:video)}
		it "returns true when the user queued the video" do
			
			Fabricate(:queue_item, user: user, video: video)
			user.queued_video?(video).should be_truthy
		end

		it "returns false when the user queued the video" do			
			user.queued_video?(video).should be_falsey
		end
	end
end