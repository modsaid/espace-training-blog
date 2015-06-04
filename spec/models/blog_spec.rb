require 'spec_helper'

describe Blog do
	it 'must have title' do
		expect(FactoryGirl.build(:blog, title: nil)).to_not be_valid
	end

	it 'is vaild blog' do
		expect(FactoryGirl.create(:blog)).to be_valid
	end
end