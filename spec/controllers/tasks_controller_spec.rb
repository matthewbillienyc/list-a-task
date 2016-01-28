require 'rails_helper'

describe TasksController do

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new task in the database" do
        expect{
          post :create, task: attributes_for(:task)
        }.to change(Task, :count).by(1)
      end
      it "responds with a JSON file" do
        post :create, task: attributes_for(:task)
        expect(response.headers['Content-Type']).to match 'json'
      end
    end

    context "with invalid attributes" do
      it "does not save the task in the database" do
        expect{
          post :create, task: attributes_for(:invalid_task)
        }.to_not change(List, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @task = create(:task)
    end

    it "deletes the task" do
      expect{
        delete :destroy, id: @task
      }.to change(Task, :count).by(-1)
    end
    it "returns a JSON file" do
      delete :destroy, id: @task
      expect(response.headers['Content-Type']).to match 'json'
    end
  end
end
