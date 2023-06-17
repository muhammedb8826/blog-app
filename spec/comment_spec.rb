require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'update_comment_counter' do
    let!(:author) { User.create name: 'Dr.Zakir', posts_counter: 0 }
    let!(:post) { Post.create author_id: author.id, title: 'Hajj', comments_counter: 0, likes_counter: 0 }
    let!(:comment) do
      Comment.create author_id: author.id, post_id: post.id, text: 'Prayer is the most important thing in Islam'
    end

    it 'should increment comments_counter by one' do
      expect(comment.update_comment_counter.comments_counter).to eq(2)
    end
  end
end
