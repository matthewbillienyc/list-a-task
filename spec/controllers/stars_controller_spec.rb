require 'rails_helper'

describe StarsController do
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new list_star in the database" do
        expect{
          post :create, star: attributes_for(:list_star)
        }.to change(Star, :count).by(1)
      end
      it "responds with a JSON file" do
        post :create, star: attributes_for(:list_star)
        expect(response.headers['Content-Type']).to match 'json'
      end
    end
    context "with valid attributes" do
      it "saves the new task_star in the database" do
        expect{
          post :create, star: attributes_for(:task_star)
        }.to change(Star, :count).by(1)
      end
      it "responds with a JSON file" do
        post :create, star: attributes_for(:task_star)
        expect(response.headers['Content-Type']).to match 'json'
      end
    end

  end

  describe "DELETE #destroy" do
    context "for a list_star" do
      before :each do
        @star = create(:list_star)
      end
      it "deletes the list_star" do
        expect{
          delete :destroy, id: @star
        }.to change(Star, :count).by(-1)
      end
      it "returns a JSON file" do
        delete :destroy, id: @star
        expect(response.headers['Content-Type']).to match 'json'
      end
    end

    context "for a task_star" do
      before :each do
        @star = create(:task_star)
      end
      it "deletes the task_star" do
        expect{
          delete :destroy, id: @star
        }.to change(Star, :count).by(-1)
      end
      it "returns a JSON file" do
        delete :destroy, id: @star
        expect(response.headers['Content-Type']).to match 'json'
      end
    end
  end
end
