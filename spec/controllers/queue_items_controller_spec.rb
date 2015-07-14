require 'spec_helper'

describe QueueItemsController do
	describe "GET index" do
		
		let (:queue_item1) {queue_item1 = Fabricate(:queue_item, user: alice)}
		let (:queue_item2) {queue_item1 = Fabricate(:queue_item, user: alice)}
		
		context "user is logged in" do
			let(:alice) { Fabricate(:user) }
			it "sets  to the queue items of the logged in user" do
				session[:user_id] = alice.id	
				get :index
				expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
			end
		end
		context "user is not logged in" do
			it "redirects to sign_in_path" do
				get :index
				expect(response).to redirect_to sign_in_path
			end
		end
	end
end