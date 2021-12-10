require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    user = User.create(name: 'Anna', bio: 'Hello! My name is Juliana.', posts_counter: 0)
    subject do
      Post.new(title: 'This is first post', text: 'Hello! My name is Juliana.', author: user, comments_counter: 2,
               likes_counter: 2)
    end

    before { subject.save }

    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should not be greater than 250 characters' do
      subject.title = 'Hello'
      expect(subject).to be_valid
    end

    it 'comments counter should be integer' do
      subject.comments_counter = 2
      expect(subject).to be_valid
    end

    it 'comments counter should be greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes counter should be greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes counter should be integer' do
      subject.likes_counter = 2.2
      expect(subject).to_not be_valid
    end

    describe 'should test methods in post model' do
      it 'post should have five recent comments' do
        expect(subject.recent_comments).to eq(subject.comments.last(5))
      end
    end
  end
end
