require 'spec_helper'

describe 'routes for Blogs', type: :routing do
  describe 'collection routes' do
    it 'routes GET /blogs to blogs#index' do
      expect(get('/blogs')).to route_to('blogs#index')
    end

    it 'routes GET /blogs/new to blogs#new' do
      expect(get('/blogs/new')).to route_to('blogs#new')
    end

    it 'routes POST /blogs to blogs#create' do
      expect(post('/blogs')).to route_to('blogs#create')
    end
  end

  describe 'member routes' do
    let :blog do
      FactoryGirl.create(:blog)
    end

    it 'routes GET /blogs/:id to blogs#show' do
      expect(get("/blogs/#{blog.id}")).to route_to(controller: 'blogs',
                                                    action:     'show',
                                                    id:         "#{blog.id}")
    end

    it 'routes GET /blogs/:id/edit to blogs#edit' do
      expect(get("/blogs/#{blog.id}/edit")).to route_to(controller: 'blogs',
                                                         action:     'edit',
                                                         id:         "#{blog.id}")
    end

    it 'routes PUT /blogs/:id to blogs#update' do
      expect(put("/blogs/#{blog.id}")).to route_to(controller: 'blogs',
                                                    action:     'update',
                                                    id:         "#{blog.id}")
    end

    it 'routes DELETE /blogs/:id to blogs#destroy' do
      expect(delete("/blogs/#{blog.id}")).to route_to(controller: 'blogs',
                                                       action:     'destroy',
                                                       id:         "#{blog.id}")
    end
  end
end