require 'spec_helper'

describe QueueItem do
	it { should belong_to :user }
	it { should belong_to :video }
	it { should validate_numericality_of(:position).only_integer }
	it { should delegate_method(:full_name).to(:user).with_prefix(:user) }
	it { should delegate_method(:title).to(:video).with_prefix(:video) }
	it { should delegate_method(:category_name).to(:video) }

	let(:alice)      { Fabricate(:video) }
	let(:gus)        { Fabricate(:user) }
	let(:queue_item) { Fabricate(:queue_item, user: gus, video: alice) }

	describe "#rating" do
		it "returns a rating from the review if review is present" do
			review = Fabricate(:review, user: gus, video: alice, rating: "4")
			expect(queue_item.rating).to eq("4")
		end
		it "returns nil if no rating" do
			expect(queue_item.rating).to eq(nil)
		end
	end
end