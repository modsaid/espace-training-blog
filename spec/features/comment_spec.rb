require 'spec_helper'
require 'capybara/rspec'

describe 'Adding Comment', type: :feature do
  before(:each) do
    @blog = FactoryGirl.create(:blog)

    login_with @blog.user.email, TESTING_PASSWORD
  end

  it 'add comment successfully' do
    visit blog_path(@blog)

    fill_in 'new_comment_textarea', with: 'My comment'

    click_button 'Add Comment'

    expect(page).to have_content('My comment')
  end

  def login_with(email, password)
    visit new_user_session_path

    fill_in 'user_email',                 with: email
    fill_in 'user_password',              with: password

    click_button 'Log in'
  end
end