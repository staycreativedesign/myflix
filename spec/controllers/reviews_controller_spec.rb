require 'spec_helper'

describe ReviewsController do
	describe "POST create" do
		let(:alice) { Fabricate(:user) }
		let(:video) { Fabricate(:video) }
		context "with valid input" do
		before { post :create, user: alice, video_id: video.id, review: Fabricate.attributes_for(:review) }	
			it "sets the @review record when input is valid" do
				expect(video.reviews.count).to eq(1)
			end
			it "redirects to the @video path" do
				expect(response).to redirect_to video_path(video)
			end
			it "sets flash[:notice]" do
				expect(flash[:notice]).not_to be_blank
			end
		end
		context "with invalid input" do
			before { post :create, user: alice, video_id: video.id, review: Fabricate.attributes_for(:review, description: nil) }
			it "does not set @review when input is invalid" do
				expect(video.reviews.count).to eq(0)
			end
			it "sets flash[:error]" do
				expect(flash[:error]).not_to be_blank
			end
			it "redirects to the @video path" do
				expect(response).to redirect_to video_path(video)
			end
		end
	end
end