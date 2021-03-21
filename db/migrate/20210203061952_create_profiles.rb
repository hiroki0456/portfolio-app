class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :profile_type
      t.bigint :profile_id
      t.timestamps
    end
  end
end
