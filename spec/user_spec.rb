require 'rails_helper'

describe User do

  describe "validations" do
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
  end

  describe "instance methods" do
    describe "#has_avatar?" do
      it "should return false if no avatar has been uploaded" do
        user = build(:user)
        expect(user.has_avatar?).to eq false
      end
    end

    describe "#lists_total" do
      it "should show # lists created by user, deleted or not" do
        user = create(:user)
        2.times do
          user.lists.create(name: "list")
        end
        user.lists.first.destroy
        expect(user.lists_total).to eq(2)
      end
    end

    describe "#tasks_total" do
      it "should show # tasks created deleted or not" do
        user = create(:user)
        list = user.lists.create(name: "list")
        2.times do
          list.tasks.create(description: "a", priority: "low")
        end
        list.tasks.first.destroy
        expect(user.tasks_total).to eq(2)
      end
    end

    describe "#total_starred_items" do
      it "should give # of starred lists and tasks, deleted or not" do
        user = create(:user)
        list = user.lists.create(name: "todo")
        task = list.tasks.create(description: "t", priority: "low")
        star = list.create_star
        task.create_star
        star.destroy
        expect(user.total_starred_items).to eq(2)
      end
    end
  end
end
