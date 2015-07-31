require 'spec_helper'

describe QueueItemsController do
  let(:current_user) { Fabricate(:user) }

  context "user is logged in" do
    let (:video1) { Fabricate(:video) }
    let (:video2) { Fabricate(:video) }
    let (:queue_item1) { Fabricate(:queue_item, user: current_user, video: video1) }
    let (:queue_item2) { Fabricate(:queue_item, user: current_user, video: video2) }
    before { session[:user_id] = current_user.id }

    describe "GET index" do     
      it "sets  to the queue items of the logged in user" do  
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    describe "POST update_queue" do
      context "valid input" do
        it "redirects to my_queue_path" do
          post :update_queue, queue_items:[{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        it "should reorder the queue items" do
          post :update_queue, queue_items:[{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(current_user.queue_items).to eq([queue_item2, queue_item1])
        end
        it "normalizes the position number" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end   
      end
      context "invalid input" do
        before {post :update_queue, queue_items:[{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.4}]}
        it "redirect_to my_queue_path" do
          expect(response).to redirect_to my_queue_path
        end

        it "sets the flash error message" do
          expect(flash[:error]).to be_present
        end
        it "does not change order"  do
          expect(queue_item1.reload.position).to eq(3)
        end
      end
      context "with queue items that do not belong to current_user" do
        it "does not change queue items" do 
          bob = Fabricate(:user)
          queue_item3 = Fabricate(:queue_item, user: bob, position: 3)
          queue_item4 = Fabricate(:queue_item, user: current_user, position: 4)
          post :update_queue, queue_items:[{id: queue_item3.id, position: 4}, {id: queue_item4.id, position: 3}]
          expect(queue_item3.reload.position).to eq(3)
        end
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
        expect(QueueItem.count).to eq(1)
      end        
    end 

    describe "DELETE destroy" do
      before { post :create, video_id: video1.id }
      before { post :create, video_id: video2.id }
      before { delete :destroy, id: QueueItem.first.id }
      
      it "the selected queue_item" do
        expect(QueueItem.count).to eq(1)
      end

      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end

      it "shows a notice" do
        expect(flash[:notice]).to be_present
      end

      it "normalizes the order of remaining item" do
        expect(QueueItem.first.position).to eq(1)
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