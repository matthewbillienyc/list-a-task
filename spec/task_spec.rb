require 'rails_helper'

describe Task do
  it "should have a valid factory" do
    expect(build(:task)).to be_valid
  end
  it "should be invalid without a description" do
    task = build(:task, description: nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end
  it "should be invalid without a priority" do
    task = build(:task, priority: nil)
    task.valid?
    expect(task.errors[:priority]).to include("can't be blank")
  end
  it "should be invalid without a list_id" do
    task = build(:task, list_id: nil)
    task.valid?
    expect(task.errors[:list_id]).to include("can't be blank")
  end
  it "can be associated with a list" do
    list = create(:list)
    task = build(:task, list: list)
    expect(task.list).to eq(list)
  end
end
