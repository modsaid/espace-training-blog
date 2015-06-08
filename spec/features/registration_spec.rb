require 'spec_helper'
require 'capybara/rspec'

describe 'Registration', type: :feature do
  it 'with valid email and password' do
    register_with 'valid@example.com', '123456789'

    expect(page).to have_css('p.alert-success')
  end

  it 'with invalid data' do
    register_with 'invalid_email', 'password'

    expect(page).to have_css('#error_explanation')
  end

  def register_with(email, password)
    visit new_user_registration_path

    fill_in 'user_email',                 with: email
    fill_in 'user_password',              with: password
    fill_in 'user_password_confirmation', with: password

    click_button 'Sign up'
  end
end