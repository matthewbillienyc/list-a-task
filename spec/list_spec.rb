require 'rails_helper'

describe List do
  it "should have a valid factory" do
    list = build(:list)
    expect(list).to be_valid
  end
  it "should be invalid without a name" do
    list = build(:list, name: nil)
    list.valid?
    expect(list.errors[:name]).to include("can't be blank")
  end
  it "should be associated to a user" do
    user = create(:user)
    list = build(:list, user: user)
    expect(list.user).to eq(user)
  end
end
