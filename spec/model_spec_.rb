require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Creating a user' do
    it 'Should be valid since all validations are true' do
      user =
        User.new(
          email: 'mario123456@gmail.com',
          password: '123456',
          name: 'mario',
          username: 'mariordgez'
        )
      expect(user).to be_valid
    end
    it 'Should not be valid since its missing email' do
      user = User.new(password: '123456')
      expect(user).to_not be_valid
    end
    it 'Should not be valid since its missing password' do
      user = User.new(email: '123456')
      expect(user).to_not be_valid
    end
    it 'Should not be valid since password lenght < 6' do
      user = User.new(email: 'mario123456@gmail.com', password: '12345')
      expect(user).to_not be_valid
    end
    it 'Should not be valid it is missing name' do
      user = User.new(email: 'mario123456@gmail.com', password: '12345')
      expect(user).to_not be_valid
    end
  end
end

RSpec.describe Tweet, type: :model do
  context 'User with a created post' do
    it 'Should be valid since all validations are true' do
      user =
        User.new(
          email: 'mario123456@gmail.com',
          password: '123456',
          name: 'mario',
          username: 'marrio'
        )
      tweet = user.tweets.new(content: 'this is a post')
      expect(tweet).to be_valid
    end
    it 'Should not be valid because its missing content' do
      user =
        User.new(
          email: 'mario123456@gmail.com',
          password: '123456',
          name: 'mario',
          username: 'marrio'
        )
      tweet = user.tweets.new(content: '')
      expect(tweet).to_not be_valid
    end
  end
end

RSpec.describe Following, type: :model do
  context 'User creates a friendship' do
    it 'Should be valid since all validations are true' do
      user1 =
        User.create(
          id: 1,
          email: 'mario123456@gmail.com',
          password: '123456',
          name: 'mario',
          username: 'marrio'
        )
      user2 =
        User.create(
          id: 2,
          email: 'alberto123456@gmail.com',
          password: '123456',
          name: 'alberto',
          username: 'alberrto'
        )
      following =
        user1.followings.build(following_id: user2.id)
      expect(following).to be_valid
    end
    it 'Should validate inverse following' do
      user1 =
        User.create(
          id: 1,
          email: 'mario123456@gmail.com',
          password: '123456',
          name: 'mario',
          username: 'marrio'
        )
      user2 =
        User.create(
          id: 2,
          email: 'alberto123456@gmail.com',
          password: '123456',
          name: 'alberto',
          username: 'alberrto'
        )
      following =
        user1.followings.create(following_id: user2.id)
      inverse = user2.inverse_followings.find_by(user_id: user1.id)
      expect(inverse.user_id).to eql(1)
    end
  end
end
