require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    it "saves a new user with name, email, and matching passwords" do
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user.errors.full_messages.size).to be(0)
    end

    it "requires a first name" do
      @user = User.create(last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "requires a last name" do
      @user = User.create(first_name: 'first', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "requires an email" do
      @user = User.create(first_name: 'first', last_name: 'last', password: 'password', password_confirmation: 'password')
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "requires a password length of 5" do
      @user = User.create(first_name: 'first', last_name: 'last', password: 'pass', password_confirmation: 'pass')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

    it "requires matching passwords" do
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'not_pass')
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "requires a unique email address" do
      @user1 = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user1.errors.full_messages.size).to be(0)
      @user2 = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "requires a unique email address (case insensitive)" do
      @user1 = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user1.errors.full_messages.size).to be(0)
      @user2 = User.create(first_name: 'first', last_name: 'last', email: 'TEST@mail.com', password: 'password', password_confirmation: 'password')
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates a valid user' do 
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('test@mail.com', 'password')).not_to be_nil
    end

    it 'authenticates a valid user with extra whitespace in email' do 
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('  test@mail.com  ', 'password')).not_to be_nil
    end

    it 'authenticates a valid user with case differences in email' do 
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('TEST@mail.com', 'password')).not_to be_nil
    end

    it 'doesn\'t authenticate an invalid user' do 
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('test1@mail.com', 'password')).to be_nil
    end

    it 'doesn\'t authenticate a user with an invalid password' do 
      @user = User.create(first_name: 'first', last_name: 'last', email: 'test@mail.com', password: 'password', password_confirmation: 'password')
      expect(User.authenticate_with_credentials('test@mail.com', 'password1')).to be_nil
    end
  end
end