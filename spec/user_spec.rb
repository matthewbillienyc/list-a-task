require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  it "is invalid without username" do
    user = build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end
  it "is invalid without password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  it "is invalid if password and password_confirmation don't match" do
    user = build(:user, password: "geee")
    user.valid?
    expect(user).to be_invalid
  end
  it "is invalid with duplicate username" do
    create(:user, username: "bob")
    user = build(:user, username: "bob")
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end
  
  context "it gets initialized with proper default values" do
    let(:user) { build(:user) }
    it "defaults 'admin' to false" do
      expect(user.admin).to eq false
    end
    it "defaults lists_total to 0" do
      expect(user.lists_total).to eq(0)
    end
    it "defaults tasks_total to 0" do
      expect(user.tasks_total).to eq(0)
    end
    it "defaults stars_total to 0" do
      expect(user.stars_total).to eq(0)
    end
  end
end
