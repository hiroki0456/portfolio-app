require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:question) {FactoryBot.create(:question)}
  let(:comment) {FactoryBot.build(:comment)}

  context 'all clear' do
    it 'can validate all attributes' do
      comment.user_id = question.user.id
      comment.question_id = question.id
      expect{comment.save}.to change{Comment.count}.by(1)
    end
  end

  context 'not all clear' do
    it "can't validate comment for nil" do
      comment.user_id = question.user.id
      comment.question_id = question.id
      comment.comment = nil
      comment.valid?
      expect(comment.errors.full_messages).to include("Commentを入力してください")
    end

    it "can't validate comment for nil" do
      comment.user_id = question.user.id
      comment.question_id = question.id
      comment.title = nil
      comment.valid?
      expect(comment.errors.full_messages).to include("Titleを入力してください")
    end
  end
end
