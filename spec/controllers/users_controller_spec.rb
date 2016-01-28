require 'rails_helper'

describe UsersController do

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = create(:user)
      get :show, id: user
      expect(assigns(:user)).to eq user
    end
    it "renders the :show template" do
      user = create(:user)
      get :show, id: user
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it "redirects to users#show" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns[:user])
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end
      it "re-renders the :new template" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe "user access" do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to user_path(@user)
    end
    it "POST #create denies access" do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to user_path(@user)
    end
  end
end
