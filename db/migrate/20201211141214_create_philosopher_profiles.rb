class CreatePhilosopherProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :philosopher_profiles do |t|
      t.text :profile
      t.string :affiliation
      t.text :research
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
