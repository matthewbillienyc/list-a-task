require 'rails_helper'

describe Star do

  it "should have a valid list_star factory" do
    list_star = build(:list_star)
    expect(list_star).to be_valid
  end
  it "should have a valid task_star factory" do
    task_star = build(:task_star)
    expect(task_star).to be_valid
  end
  it "can be associated with a list" do
    list_star = build(:list_star)
    expect(list_star.starable_type).to eq("List")
  end
  it "can be associated with a task" do
    task_star = build(:task_star)
    expect(task_star.starable_type).to eq("Task")
  end
end
