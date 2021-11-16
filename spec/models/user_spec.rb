require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do

    it 'must be created with password and password_confirmation' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => nil,
        :password_confirmation => nil 
      )
      expect(@user.save).to eq(false)
    end

    it 'must have a unique email' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456'
      )
      @user.save

      @user_2 = User.new(
        :first_name => 'Paul',
        :last_name => 'Dennis',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456'
      )

      @user_3 = User.new(
        :first_name => 'Paul',
        :last_name => 'Dennis',
        :email => 'test1@TEST.COM',
        :password => '123456',
        :password_confirmation => '123456'
      )

      expect(@user_2.save).to eq(false)
      expect(@user_3.save).to eq(false)
    
    end


    it 'must have an email' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => nil,
        :password => '123456',
        :password_confirmation => '123456'
      )
      expect(@user.save).to eq(false)
    end


    it 'must have a first name' do
      @user = User.new(
        :first_name => nil,
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456'
      )
      expect(@user.save).to eq(false)
    end


    it 'must have a last name'do
    @user = User.new(
      :first_name => 'John',
      :last_name => nil,
      :email => 'test1@test.com',
      :password => '123456',
        :password_confirmation => '123456' 
    )
    expect(@user.save).to eq(false)
    end

    it 'must have a password length of 6' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123',
        :password_confirmation => '123' 
      )
      expect(@user.save).to eq(false)
    end


  end

  describe '.authenticate_with_credentials' do

    it 'does not log in with wrong password' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456' 
      )
      @user.save

      expect(@user.authenticate_with_credentials('test1@test.com', '1111111')).to eq(nil)
    end

    it 'logs in with right password' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456' 
      )
      @user.save

      @auth_user = @user.authenticate_with_credentials('test1@test.com', '123456')
      expect(@auth_user).to_not be_nil
      expect(@auth_user.first_name).to eq('John')
      expect(@auth_user.last_name).to eq('Doe')
    end

    it 'logs in with extra whitespace in before email' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456' 
      )
      @user.save

      @auth_user = @user.authenticate_with_credentials('   test1@test.com', '123456')
      expect(@auth_user).to_not be_nil
      expect(@auth_user.first_name).to eq('John')
      expect(@auth_user.last_name).to eq('Doe')
    end

    it 'logs in wrong case for email - login side' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@test.com',
        :password => '123456',
        :password_confirmation => '123456' 
      )
      @user.save

      @auth_user = @user.authenticate_with_credentials('test1@TEST.COM', '123456')
      expect(@auth_user).to_not be_nil
      expect(@auth_user.first_name).to eq('John')
      expect(@auth_user.last_name).to eq('Doe')
    end

    it 'logs in wrong case for email - create new side' do
      @user = User.new(
        :first_name => 'John',
        :last_name => 'Doe',
        :email => 'test1@TEST.COM',
        :password => '123456',
        :password_confirmation => '123456' 
      )
      @user.save

      @auth_user = @user.authenticate_with_credentials('test1@test.com', '123456')
      expect(@auth_user).to_not be_nil
      expect(@auth_user.first_name).to eq('John')
      expect(@auth_user.last_name).to eq('Doe')
    end

  end

end
