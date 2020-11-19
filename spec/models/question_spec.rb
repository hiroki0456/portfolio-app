require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) {FactoryBot.build(:question)}

  context 'all clear' do
    it 'can validate all attributes' do
      expect{question.save}.to change{Question.count}.by(1)
    end
  end

  context 'not all clear' do
    it "can't validate category for nil" do
      question.category_id = nil
      question.valid?
      expect(question.errors.full_messages).to include("Category can't be blank")
    end

    it "can't validate category for 0" do
      question.category_id = 0
      question.valid?
      expect(question.errors.full_messages).to include("Category Select")
    end

    it "can't validate title for nil" do
      question.title = nil
      question.valid?
      expect(question.errors.full_messages).to include("Title can't be blank")
    end

    it "can't validate title greater than 20" do
      question.title = "a" * 21
      question.valid?
      expect(question.errors.full_messages).to include("Title is too long (maximum is 20 characters)")
    end

    it "can't validate question for nil" do
      question.question = nil
      question.valid?
      expect(question.errors.full_messages).to include("Question can't be blank")
    end

    it "can't validate question greater than 1001" do
      question.question = "a" * 1001
      question.valid?
      expect(question.errors.full_messages).to include("Question is too long (maximum is 1000 characters)")
    end
  end
end
