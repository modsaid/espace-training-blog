require 'spec_helper'

describe BlogsController do
  include Devise::TestHelpers

  context 'needs an exisiting blog' do
    before(:each) do
      @blog = FactoryGirl.create(:blog)

      sign_in @blog.user
    end

    describe 'GET #index' do
      it 'prepare array of blogs' do
       get :index

        expect(assigns(:blogs)).to eq([@blog])
      end
  
      it 'renders the :index template' do
        get :index

        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      before(:each) do
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

    describe 'PUT #update' do
      context 'with valid attributes' do
        it 'edits the blog' do
          editing_blog_attributes = FactoryGirl.attributes_for(:blog)

          put :update, blog: editing_blog_attributes, id: @blog.id

          expect(@blog.title).to eq editing_blog_attributes[:title]
        end

        it 'redirects to the blog after editing' do
          post :update, blog: FactoryGirl.attributes_for(:blog), id: @blog.id

          expect(response).to redirect_to @blog
        end
      end

      context 'with invalid attributes' do
        it 'does not save the edits to the blog' do
          expect{ post :update, blog: FactoryGirl.attributes_for(:blog, title: nil), id: @blog.id }.to_not change(@blog, :title)
        end

        it 're-renders edit blog template' do
          post :update, blog: FactoryGirl.attributes_for(:blog, title: nil), id: @blog.id

          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes the blog' do
        delete :destroy, id: @blog.id

        expect(Blog.count).to eq 0
      end

      it 'redirects to blogs index' do
          delete :destroy, id: @blog.id

          expect(response).to redirect_to blogs_path
        end
    end
  end

  context 'creating blog' do
    let(:user){FactoryGirl.create(:user)}

    before(:each) do
      # user = FactoryGirl.create(:user)

      sign_in user
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new blog' do
          expect{ post :create, blog: FactoryGirl.attributes_for(:blog) }.to change(Blog, :count).by(1)
        end

        it 'should prevent creating blog associated with other users' do 
          fake_user_id = user.id + 10
          attributes = FactoryGirl.attributes_for(:blog).merge(user_id: fake_user_id)
          expect{ post :create, blog: attributes }.to change(user.blogs, :count).by(1)
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
end