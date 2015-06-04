require 'spec_helper'

describe User do
	it 'must have email' do
		expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
	end

	it 'is vaild user' do
		user = FactoryGirl.build(:user)
		user.skip_confirmation!
		user.save!
		expect(user).to be_valid
	end
end