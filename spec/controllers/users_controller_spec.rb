require 'spec_helper'

describe UsersController do
	describe "GET new" do
		it "sets the @user variable" do
			get :new
			assigns(:user).should be_a_new(User)
			assigns(:user).should be_instance_of(User)
		end
		it "renders new template" do
			get :new
			response.should render_template :new
		end
	end

	describe "POST create" do
		it "sets the @user record when input is valid" do 
			post :create, user: Fabricate.attributes_for(:user)
		end
		it "redirects to the root path when the input is valid" do
			post :create, user: Fabricate.attributes_for(:user)
			response.should redirect_to root_path
		end
		it "does not save @user with missing parameters" do 
			post :create, user: Fabricate.attributes_for(:user, password: nil)
			User.count.should == 0
			response.should render_template(:new)
		end
		it "renders the new template when the input is invalid" do
			post :create, user: Fabricate.attributes_for(:user)
			response.should redirect_to root_path
		end
	end
end

