require 'spec_helper'

describe 'devise routes', type: :routing do
  describe 'session routes' do
    it 'routes GET /users/sign_in to devise/sessions#new' do
      expect(get('/users/sign_in')).to route_to('devise/sessions#new')
    end

    it 'routes POST /users/sign_in to devise/sessions#create' do
      expect(post('/users/sign_in')).to route_to('devise/sessions#create')
    end

    it 'routes GET /users/sign_out to devise/sessions#destroy' do
      expect(get('/users/sign_out')).to route_to('devise/sessions#destroy')
    end
  end

  describe 'users routes' do
    it 'routes GET /users/sign_up to users/registrations#new' do
      expect(get('/users/sign_up')).to route_to('users/registrations#new')
    end

    it 'routes POST /users to users/registrations#create' do
      expect(post('/users')).to route_to('users/registrations#create')
    end
  end
end