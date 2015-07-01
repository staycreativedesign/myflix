require 'spec_helper'

describe Category do
	it { should have_many(:videos)}

	describe "#recent_videos" do
		it "returns the videos in the reverse chronical order by created at" do
			comedies = Category.create(name: "comedies")
			home_alone_deux = Video.create(title: "Home Alone 2", description: "Kid left alone in house.", category: comedies, created_at: 1.day.ago)
			home_alone = Video.create(title: "Home Alone", description: "Kid left alone in house.", category: comedies)
			expect(comedies.recent_videos).to eq([home_alone, home_alone_deux])
		end
		it "returns 6 vidoes if there are more than 6 videos" do
			comedies = Category.create(name: "comedies")
				7.times do 
					home_alone = Video.create(title: "Home Alone", description: "Kid left alone in house.", category: comedies)
				end
			expect(comedies.recent_videos.count). to eq(6)
		end
		it "returns the most recent 6 videos" do
  		comedies = Category.create(name: "comedies")
			6.times do 
				home_alone = Video.create(title: "Home Alone", description: "Kid left alone in house.", category: comedies)
			end
			shrek = Video.create(title: "Shrek", description: "Kid left alone in house.", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos).not_to include(shrek)

		end
		it "returns an empty array if the category does not have any videos" do
  		comedies = Category.create(name: "comedies")
			expect(comedies.recent_videos).to eq([])			
		end
	end
end