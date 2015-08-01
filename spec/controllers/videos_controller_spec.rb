require 'spec_helper'

describe VideosController do
	let(:video_1) { Fabricate(:video, title: 'Futurama')}
	let(:video_2) { Fabricate(:video, title: 'Back to the Future')}
	let(:gus)        { Fabricate(:user) }
	
	describe "GET show" do
		it "sets @video for authenticated users" do
			session[:user_id] = Fabricate(:user).id
			get :show, id: video_1.id
			expect(assigns(:video)).to eq(video_1) 
		end
		
		it "sets the @reviews for authenticated users" do
			session[:user_id] = gus.id
			review = Fabricate(:review, video: video_1)
			get :show, id: video_1.id
			expect(assigns(:reviews)).to match_array([review])
		end

		it "redirects to sign_in for unauthenticated users" do
			get :show, id: video_1.id
			expect(response).to redirect_to sign_in_path
		end
	end

	describe "GET search" do
		it "sets @results for authenticated users" do
			session[:user_id] = Fabricate(:user).id
			get :search, search_term: 'rama'
			expect(assigns(:results)).to eq([video_1])
		end

		it "redirects to sign_in for unauthenticated users" do
			get :show, id: video_1.id
			expect(response).to redirect_to sign_in_path
		end
	end

end