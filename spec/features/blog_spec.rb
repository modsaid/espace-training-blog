require 'spec_helper'
require 'capybara/rspec'

describe 'Blog Features', type: :feature do

  context 'with no exisiting blog' do
    before(:each) do
      @user = FactoryGirl.create(:user)

      login_with @user.email, TESTING_PASSWORD
    end

    it 'created successfully' do
      visit blogs_path

      click_link 'New Blog'

      fill_blog_form_with('Title', 'Content', @user)

      click_button 'Create Blog'

      expect(page).to have_content('Blog was successfully created.')
    end
  end

  describe 'with exisiting blog' do
    before(:each) do
      @blog = FactoryGirl.create(:blog)

      login_with @blog.user.email, TESTING_PASSWORD
    end

    it "edited successfully" do
      visit blogs_path

      click_link 'Edit'

      fill_blog_form_with('Edited Title', 'Edited Content', @blog.user)

      click_button 'Update Blog'

      expect(page).to have_content('Blog was successfully updated.')
    end
  end

  def login_with(email, password)
    visit new_user_session_path

    fill_in 'user_email',                 with: email
    fill_in 'user_password',              with: password

    click_button 'Log in'
  end

  def fill_blog_form_with(title, content, user)
    fill_in 'blog_title', with: title
    fill_in 'blog_body',  with: content
    select(user.name,    from: 'blog[user_id]')
  end
end