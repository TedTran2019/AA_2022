require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { User.new(email: 'Ted', password: 'password') }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:session_token) }
    it 'should validate presence of password_digest with a specific message' do
      empty_password_digest = User.new(email: 'Ted')
      empty_password_digest.valid?
      expect(empty_password_digest.errors[:password_digest]).to include("Can't be blank")
    end
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
    it 'allows password to be nil' do
      no_password_user= User.new(email: 'Ted', password: nil)
      no_password_user.password_digest = 'password_digest'
      expect(no_password_user.valid?).to be(true)
    end
  end

  describe 'associations' do
    it { should have_many(:notes) }
  end

  describe 'methods' do
    describe 'User::find_by_credentials' do
      it 'should return a user if the credentials are valid' do
        user = User.create!(email: 'Ted', password: 'password')
        expect(User.find_by_credentials('Ted', 'password')).to eq(user)
      end
      it 'should return nil if the credentials are invalid' do
        user = User.create!(email: 'Ted', password: 'password')
        expect(User.find_by_credentials('Ted', 'wrong_password')).to eq(nil)
      end
    end

    describe 'User::generate_session_token' do
      it 'should generate a session token' do
        expect(User.generate_session_token).to be_a(String)
      end
    end

    describe 'User#reset_session_token!' do
      it 'should reset the user\'s session token' do
        user = User.new(email: 'Ted', password: 'password')
        orig_session_token = user.session_token
        user.reset_session_token!
        expect(orig_session_token).to_not eq(user.session_token)
      end
    end

    describe 'User#ensure_session_token' do
      it 'should set the user\'s session token' do
        user = User.new(email: 'Ted', password: 'password')
        expect(user.session_token).to_not be_nil
      end
    end

    describe 'User#password=' do
      it 'should set the user\'s password' do
        user = User.new(email: 'Ted')
        user.password = 'password'
        expect(user.password).to eq('password')
        expect(user.password_digest).to_not be_nil
      end
    end

    describe 'User#is_password?' do
      user = User.new(email: 'Ted', password: 'password')
      it 'should return true if the password is correct' do
        expect(user.is_password?('password')).to be(true)
      end
      it 'should return false if the password is incorrect' do
        expect(user.is_password?('wrong_password')).to be(false)
      end
    end
  end
end
