require 'rails_helper'

describe Task do
  it "should have a valid factory" do
    expect(build(:task)).to be_valid
  end
end
