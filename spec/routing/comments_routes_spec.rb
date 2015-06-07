require 'spec_helper'

describe 'routes for Comments', type: :routing do
  it 'routes POST /comments to comments#create' do
    expect(post('/comments')).to route_to('comments#create')
  end
end