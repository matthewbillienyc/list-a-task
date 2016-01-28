require 'rails_helper'

describe List do
  it "should be valid with a name and user_id" do
    list = List.new(
      name: "To Do",
      user_id: 1
    )
    expect(list).to be_valid
  end
  it "should be invalid without a name" do
    list = List.new(
      name: nil,
      user_id: 1
    )
    list.valid?
    expect(list.errors[:name]).to include("can't be blank")
  end
  it "should be invalid without user_id" do
    list = List.new(
      name: "To Don't",
      user_id: nil
    )
    list.valid?
    expect(list.errors[:user_id]).to include("can't be blank")
  end
  it "should be associated to a user" do
    user = User.first
    list = List.create(
      name: "To Maybe",
      user_id: 1
    )
    expect(list.user).to eq(user)
  end
end
