require 'spec_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }

	describe "search_by_title" do
		let(:video_1) { Fabricate(:video)}
		let(:video_2) { Fabricate(:video)}
		let(:futurama) { futurama = Video.create(title: "Futurama", description: "Space video") }
		let(:back_to_future) { back_to_future = Video.create(title: "Back to the Future", description: "Space Travel", created_at: 1.day.ago) }

		it "returns an empty array if there is no match" do
			video_1
			video_2 
			expect(Video.search_by_title(Faker::Lorem.word)).to eq([])
		end
		
		it "returns an array of one video for an exact match" do
			video_1
			expect(Video.search_by_title(video_1.title)).to eq([video_1])
		
		end
		
		it "returns an array of one video for a partial match" do
			futurama
			expect(Video.search_by_title("Fut")).to eq([futurama])
		end
		
		it "returns an array of all matches ordered by created_at" do
			futurama
			back_to_future
			expect(Video.search_by_title("Fut")).to eq([futurama, back_to_future])
		end

		it "returns a empty array for a search with an empty string" do
			expect(Video.search_by_title('')).to eq([])
		end
	end
end