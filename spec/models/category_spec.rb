require 'spec_helper'

describe Category do
	it { should validate_presence_of(:name)}
	it { should have_many(:videos)}

	describe "#recent_videos" do
		let(:comedies)   { Fabricate(:category, name: "comedies") }
		let(:new_video) { Fabricate(:video, category: comedies)}
		let(:old_video) { Fabricate(:video, category: comedies, created_at: 1.day.ago) }
		
		it "returns the videos in the reverse chronical order by created at" do
			new_video
			old_video
			expect(comedies.recent_videos).to eq([old_video, new_video])	
		end
		 
		it "returns 6 vidoes if there are more than 6 videos" do
			6.times do
				Fabricate(:video, category: comedies)
			end
			Fabricate(:video, category: comedies, title: 'Last Video')
			
			expect(comedies.recent_videos.count).to eq(6)
		end
		
		it "returns the most recent 6 videos" do
			video1 =	Fabricate(:video, category: comedies, created_at: 6.hours.ago)
			video2 =	Fabricate(:video, category: comedies, created_at: 5.hours.ago)
			video3 = 	Fabricate(:video, category: comedies, created_at: 4.hours.ago)
			video4 = 	Fabricate(:video, category: comedies, created_at: 3.hours.ago)
			video5 =	Fabricate(:video, category: comedies, created_at: 2.hours.ago)
			video6 =	Fabricate(:video, category: comedies, created_at: 1.hours.ago)

  		expect(comedies.recent_videos).to eq([video1,video2,video3,video4,video5, video6])
			end
		
		it "returns an empty array if the category does not have any videos" do
			expect(comedies.recent_videos).to eq([])
		end
	end
end