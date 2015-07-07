require 'spec_helper'

describe SessionsController do
	describe "GET new" do
		it "redirects to new template for unathorized users" do
			get :new
			expect(response).to render_template :new
		end
		it "redirects to home_path for authorized users" do
			session[:user_id] = Fabricate(:user).id
			get :new
			expect(response).to redirect_to home_path

		end
	end

	describe "POST create" do
  	let(:alice) { Fabricate(:user) }	
		context "with valid sign up input" do
			before { post :create, email: alice.email, password: alice.password }
			
			it "put the signed in user in the session" do
		 		expect(session[:user_id]).to eq(alice.id)
		 	end
		 
			it "redirects to the home_path"	do
		 		expect(response).to redirect_to home_path
			end

			it "sets flash notice" do
				expect(flash[:notice]).not_to be_blank
			end
		end
		
		context "with invalid sign up input" do
			before { post :create, email: alice.email, password: nil }		
			
			it "does not put the user in the session" do
				expect(session[:user_id]).to be_nil
			end

			it "redirects to the sign_in page" do
				expect(response).to redirect_to sign_in_path
			end	

			it "sets flash error" do
				expect(flash[:error]).not_to be_blank
			end		

		end
	end

	describe "GET destroy" do
		let(:alice) { Fabricate(:user) }	
		before do
			session[:user_id] = alice.id
			get :destroy
		end
		it "sets the user session to nil" do
			expect(session[:user_id]).to be_nil
		end
		it "redirects to root path" do
			expect(response).to redirect_to root_path
		end
		it "sets flash notice" do
			expect(flash[:notice]).not_to be_blank
		end
	end
end