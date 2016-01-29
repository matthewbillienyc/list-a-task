require 'rails_helper'

describe CreateListServices do

  before :each do
    user = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user_id: user.id)
    list_services = CreateListServices.new(list)
  end
  describe "#initialize" do
    it "should not raise error with one argument" do
      expect{ list_services }.to_not raise_error
    end
    it "should set the list to the self.list method" do
      expect(list_services.list).to eq list
    end
  end

  before :each do
    user = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user_id: user.id)
    list_services = CreateListServices.new(list)
  end
  describe "#call" do
    it "should increment the list's user's total_lists count by 1" do
      list_services.call
      expect(list_services.list.user.lists_total).to eq(1)
    end
  end
end
