require 'spec_helper'

describe BlogsController do
  include Devise::TestHelpers

  before(:each) do
    user = FactoryGirl.build(:user)
    user.skip_confirmation!
    user.save!

    sign_in user
  end

  let :create_blog do
    FactoryGirl.create(:blog)
  end

  describe 'GET #index' do
    it 'prepare array of blogs' do
      blog = create_blog

      get :index

      expect(assigns(:blogs)).to eq([blog])
    end

    it 'renders the :index template' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before(:each) do
      @blog = create_blog

      get :show, id: @blog
    end

    it 'get the requested blog' do
      expect(assigns(:blog)).to eq(@blog)
    end

    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new blog' do
        expect{ post :create, blog: FactoryGirl.attributes_for(:blog) }.to change(Blog, :count).by(1)
      end

      it 'redirects to the new blog' do
        post :create, blog: FactoryGirl.attributes_for(:blog)

        expect(response).to redirect_to Blog.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new blog' do
        expect{ post :create, blog: FactoryGirl.attributes_for(:blog, title: nil) }.to_not change(Blog,:count)
      end

      it 're-renders the new method' do
        post :create, blog: FactoryGirl.attributes_for(:blog, title: nil)

        expect(response).to render_template :new
      end
    end
  end
end