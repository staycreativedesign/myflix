require 'spec_helper'

describe UsersController do
  describe "GET show" do
    let(:alice) { Fabricate(:user) }  
    before do
      video = Fabricate(:video)
      review = Fabricate(:review, user: alice, video: video)
      8.times do
        Fabricate(:queue_item, user: alice, video: Fabricate(:video))
      end
      get :show, id: alice.id
    end

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "sets the @queue_items variable" do
      expect(alice.queue_items.count).to eq(8)
    end

    it "sets the @reviews variable" do
      expect(Review.where(user_id: alice).count).to eq(1)
    end


  end

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
        expect(User.count).to eq(1)
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

