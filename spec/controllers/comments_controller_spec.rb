require 'spec_helper'

describe CommentsController do
	include Devise::TestHelpers

	before(:each) do
		user = FactoryGirl.build(:user)
		user.skip_confirmation!
		user.save!

		sign_in user

		@blog = FactoryGirl.create(:blog)
	end

	describe 'POST #create' do
		it 'changes comments count by 1' do
			expect{ post :create, comment: FactoryGirl.attributes_for(:comment, blog_id: @blog.id) }.to change(Comment, :count).by(1)
		end

		it 'renders comment partial' do
			post :create, comment: FactoryGirl.attributes_for(:comment, blog_id: @blog.id)

			expect(response).to render_template(partial: 'comments/_comment')
		end
	end
end