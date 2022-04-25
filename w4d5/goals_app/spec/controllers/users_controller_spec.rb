require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it 'validates the presence of the user\'s username and password' do
        post :create, params: { user: { username: '', password: '' } }
        expect(response).to render_template('new')
      end
      it 'validates that the password is at least 6 characters long' do
        post :create, params: { user: { username: 'ted', password: '12345' } }
        expect(response).to render_template('new')
      end
    end

    context 'with valid params' do
      it 'redirects user to show page on success' do
        post :create, params: { user: { username: 'Ted', password: '123456' } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
end
