class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :category, null: false
      t.string :title, null: false
      t.text :question, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
