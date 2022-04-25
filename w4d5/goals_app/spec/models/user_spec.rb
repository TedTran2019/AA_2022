# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do 
    FactoryBot.build(:user,
    username: 'Ted',
    password: 'password')
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it 'should validate presence of password_digest with custom message' do
      no_password_digest = User.new(username: 'Teddy')
      no_password_digest.valid?
      expect(no_password_digest.errors[:password_digest]).to include("Password_digest can't be blank")
    end
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
    it 'allows password to be nil' do
      user.password = nil
      user.password_digest = 'random'
      expect(user).to be_valid
    end
  end
  
  describe 'associations' do

  end

  describe 'methods' do
    describe 'User::find_by_credentials' do
      before(:each) { user.save! }

      it 'should return user if username and password match' do
        expect(User.find_by_credentials('Ted', 'password')).to eq(user)
      end

      it 'should return nil if username and password do not match' do
        expect(User.find_by_credentials('Ted', 'wrong_password')).to eq(nil)
      end
    end

    describe 'User.generate_session_token' do
      it 'generates a session token' do
        session_token = User.generate_session_token
        expect(session_token).to be_a String
      end
    end

    describe 'User#password=' do
      it 'sets the password' do
        user.password = 'password'
        expect(user.password).to eq('password')
      end
    end

    describe 'User#reset_session_token!' do
      it 'resets the session token' do
        orig_session_token = user.session_token
        user.reset_session_token!
        expect(orig_session_token).to_not eq(user.session_token)
      end
    end

    describe 'User#is_password?' do
      it 'should return true if password is correct' do
        expect(user.is_password?('password')).to be true
      end

      it 'should return false if password is incorrect' do
        expect(user.is_password?('wrong_password')).to be false
      end
    end

    describe 'User#ensure_session_token' do
      it 'should make sure session token is never nil' do
        expect(user.session_token).to_not be_nil
      end
    end
  end
end
