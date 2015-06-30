require 'spec_helper'

describe Video do
	it { should belong_to(:category)}
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:description) }

	describe "search_by_title" do
		it "returns an empty array if there is no match" do
			futurama = Video.create(title: "Futurama", description: "Space video")
			back_to_future = Video.create(title: "Back to the Future", description: "Space Travel")
			expect(Video.search_by_title("hello")).to eq([])
		end
		it "returns an array of one video for an exact match" do

			futurama = Video.create(title: "Futurama", description: "Space video")
			expect(Video.search_by_title("Futurama")).to eq([futurama])
		
		end
		it "returns an array of one video for a partial match" do
			futurama = Video.create(title: "Futurama", description: "Space video")
			expect(Video.search_by_title("Fut")).to eq([futurama])
		end
		it "returns an array of all matches ordered by created_at" do
			futurama = Video.create(title: "Futurama", description: "Space video")
			back_to_future = Video.create(title: "Back to the Future", description: "Space Travel", created_at: 1.day.ago)
			expect(Video.search_by_title("Fut")).to eq([back_to_future, futurama])
		end
	end
end