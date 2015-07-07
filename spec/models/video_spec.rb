require 'spec_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }

	describe "search_by_title" do
		let(:video_1) { Fabricate(:video, title: 'Futurama')}
		let(:video_2) { Fabricate(:video, title: 'Back to the Future', created_at: 1.day.ago )}

		it "returns an empty array if there is no match" do
			expect(Video.search_by_title(Faker::Lorem.word)).to eq([])
		end
		
		it "returns an array of one video for an exact match" do
			expect(Video.search_by_title(video_1.title)).to eq([video_1])
		
		end
		
		it "returns an array of one video for a partial match" do
			expect(Video.search_by_title("rama")).to eq([video_1])
		end
		
		it "returns an array of all matches ordered by created_at" do
			expect(Video.search_by_title("Fut")).to eq([video_2, video_1])
		end

		it "returns a empty array for a search with an empty string" do
			expect(Video.search_by_title('')).to eq([])
		end
	end
end