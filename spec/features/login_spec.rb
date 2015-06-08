require 'spec_helper'
require 'capybara/rspec'

describe 'Log in', type: :feature do
  it 'with exisiting user' do
    user = FactoryGirl.build(:user)
    user.skip_confirmation!
    user.save!

    login_with user.email, ENV['testing_password']

    expect(page.current_path).to eq root_path
  end

  it 'with not exisiting user' do
    login_with 'ab.cd@ef.com', ENV['testing_password']

    expect(page).to have_css('.alert-danger')
  end

  def login_with(email, password)
    visit new_user_session_path

    fill_in 'user_email',                 with: email
    fill_in 'user_password',              with: password

    click_button 'Log in'
  end
end