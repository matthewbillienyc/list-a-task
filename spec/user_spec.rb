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
    expect(build(:user, username: "bob")).to be_invalid
  end
end
