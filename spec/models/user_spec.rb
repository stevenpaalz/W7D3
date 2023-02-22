# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string           not null
#  session_token   :string           not null
#
require 'rails_helper'

RSpec.describe User, type: :model do


  describe "validations" do
    it { should validate_presence_of(:username)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_presence_of(:session_token)}
    it { should validate_length_of(:password).is_at_least(6)}
  end

  describe "uniqueness" do
    before :each do
      create(:user)
    end

    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}
  end

  subject(:test_user) {User.create(
    username: 'amin',
    password: 'aminbabar'
  )}

  describe "User::find_by_credentials" do 
    it "should find user" do
      expect(User.find_by_credentials('amin', 'aminbabar')).to be(test_user)
    end
  end

  describe "#is_password?" do
    it "should return true when password is correct" do
      expect(test_user.is_password?('aminbabar')).to be true
    end
    it "should return false when password is not correct" do
      expect(test_user.is_password?('itswrong')).to be false
    end

  end

  describe "#password=" do 
    it "should receive BCrypt::Password.create method call" do
      expect(BCrypt::Password).to receive(:create)
      User.create(username: 'Test', password: "passwordtest")
    end
  end

  describe "#generate_session_token" do
    it "should generate a session token" do
      expect(test_user.generate_session_token).to be_a(String)
    end
  end

  describe "#reset_session_token" do
    it "new session token should be different than previous" do
      current_token = test_user.session_token
      test_user.reset_session_token
      expect(test_user.session_token).to_not eq(current_token)
    end
  end

end
