require 'spec_helper'

describe Comment do
  it 'must have body' do
    expect(FactoryGirl.build(:comment, body: nil)).to_not be_valid
  end

  it 'is vaild comment' do
    expect(FactoryGirl.create(:comment)).to be_valid
  end
end