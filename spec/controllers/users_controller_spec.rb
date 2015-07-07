require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets the @user variable" do
			get :new
			assigns(:user).should be_a_new(User)
			expect(assigns(:user)).to be_instance_of(User)
		end
		it "renders new template" do
			get :new
			response.should render_template :new
		end
	end
	describe "POST create" do
		
		context "with valid input" do
			before {post :create, user: Fabricate.attributes_for(:user)}
			it "sets the @user record when input is valid" do 
				expect(User.count).to eql(1)
			end
			it "redirects to the root path when the input is valid" do
				expect(response).to redirect_to root_path
			end
		end

		context "with invalid input" do
			before {post :create, user: Fabricate.attributes_for(:user, password: nil)}
			it "does not save @user with missing parameters" do 
				expect(User.count).to eql(0)
			end
			it "renders the new template when the input is invalid" do
				expect(response).to render_template(:new)
			end
		end
		
	end
end

