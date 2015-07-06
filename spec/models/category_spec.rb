require 'spec_helper'

describe Category do
	it { should have_many(:videos)}

	describe "#recent_videos" do
		before {comedies = Category.create(name: "comedies")
		let (:video) {home_alone = Video.create(title: "Home Alone", description: "Kid left alone in house.", category: comedies)}
		let (:old_video) {home_alone_deux = Video.create(title: "Home Alone 2", description: "Kid left alone in house.", category: comedies, created_at: 1.day.ago)}
		
		it "returns the videos in the reverse chronical order by created at" do
			video
			expect(comedies.recent_videos).to eq([:video, :old_video])
		end
		
		it "returns 6 vidoes if there are more than 6 videos" do
			7.times {|video| puts video}
			expect(comedies.recent_videos.count). to eq(6)
		end
		
		it "returns the most recent 6 videos" do
			6.times {|video| puts video}
			old_video
			expect(comedies.recent_videos).not_to include(:old_video)
		end
		it "returns an empty array if the category does not have any videos" do
			expect(comedies.recent_videos).to eq([])			
		end
	end
end