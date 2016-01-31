require 'rails_helper'

describe ListsController do

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new list in the database" do
        expect{
          post :create, list: attributes_for(:list)
        }.to change(List, :count).by(1)
      end
      it "responds with a JSON file" do
        post :create, list: attributes_for(:list)
        expect(response.headers['Content-Type']).to match 'json'
      end
    end

    context "with invalid attributes" do
      it "does not save the list in the database" do
        expect{
          post :create, list: attributes_for(:invalid_list)
        }.to_not change(List, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @list = create(:list)
    end

    it "deletes the list" do
      expect{
        delete :destroy, id: @list
      }.to change(List, :count).by(-1)
    end
    it "returns a JSON file" do
      delete :destroy, id: @list
      expect(response.headers['Content-Type']).to match 'json'
    end
  end
end
