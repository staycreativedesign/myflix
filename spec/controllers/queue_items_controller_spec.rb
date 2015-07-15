require 'spec_helper'

describe QueueItemsController do
  let (:video1) { Fabricate(:video) }
  let (:video2) { Fabricate(:video) }
  let (:queue_item1) { Fabricate(:queue_item, user: current_user, video: video1) }
  let (:queue_item2) { Fabricate(:queue_item, user: current_user, video: video2) }
  let(:current_user) { Fabricate(:user) }

  context "user is logged in" do
    before { session[:user_id] = current_user.id }
    describe "GET index" do     
      it "sets  to the queue items of the logged in user" do  
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    describe "POST create" do
      before { post :create, video_id: video1.id }

      it "creates a queue item" do
        expect(QueueItem.count).to eq(1)  
      end

      it "creates queue_item associated to video" do
        expect(QueueItem.first.video).to eq(video1)
      end 

      it "creates queue_item_associated to user" do
        expect(QueueItem.first.user).to eq(current_user)
      end

      it "puts newest video as the last one in the queue" do
        post :create, video_id: video2.id
        expect(QueueItem.last.position).to eql(2)
      end

      it "does not put video in queue if already in queue" do
        post :create, video_id: video1.id
        expect(QueueItem.count).to eq(1)
      end        
    end
  end
  context "user is not logged in" do
    it "redirects to sign_in_path" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
end