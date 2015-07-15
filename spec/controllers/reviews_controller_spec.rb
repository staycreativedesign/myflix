require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    
    context "with authenticated users" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      context "with valid input" do
      before { post :create, user: current_user, video_id: video.id, review: Fabricate.attributes_for(:review) }  
        it "creates a review" do
          expect(video.reviews.count).to eq(1)
        end
        it "creates a review associated with a video" do
          expect(video.reviews.first.video).to eq(video)
        end
        it "creates a review associated to a user" do
          expect(video.reviews.first.user).to eq(current_user)
        end

        it "only lets 1 user create 1 review for 1 video" do
          post :create, user: current_user, video_id: video.id, review: Fabricate.attributes_for(:review)
          expect(video.reviews.count).to eq(1)
        end
        
        it "redirects to the video show page" do
          expect(response).to redirect_to video_path(video)
        end
        it "sets flash[:notice]" do
          expect(flash[:notice]).not_to be_blank
        end
      end

      context "with invalid input" do
        before { post :create, user: current_user, video_id: video.id, review: Fabricate.attributes_for(:review, description: nil) }
        it "does not set @review when input is invalid" do
          expect(video.reviews.count).to eq(0)
        end
        it "sets flash[:error]" do
          expect(flash[:error]).not_to be_blank
        end
        it "renders video/show template" do
          expect(response).to redirect_to "videos/show"
        end
      end 
    end
    context "with unathenticated users" do
      before { post :create, user: nil, video_id: video.id, review: Fabricate.attributes_for(:review) } 
      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end