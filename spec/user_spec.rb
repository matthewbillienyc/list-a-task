require 'rails_helper'

describe User do
  it "is valid with a username, password, and password_confirmation" do
    user = User.new(
      username: "MatthewB",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end
  it "is invalid without username" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end
  it "is invalid without password" do
    user = User.new(
      username: "Bob",
      password: nil
    )
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  it "is invalid if password and password_confirmation don't match" do
    user = User.new(
      username: "Bill",
      password: "p",
      password_confirmation: "e"
    )
    user.valid?
    expect(user).to be_invalid
  end
  it "is invalid with a duplicate username" do
    User.create(
      username: "Bobby",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      username: "Bobby",
      password: "password",
      password_confirmation: "password"
    )
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
  end
end
