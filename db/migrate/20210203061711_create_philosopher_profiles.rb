class CreatePhilosopherProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :philosopher_profiles do |t|
      t.string :affiliation
      t.text :research

      t.timestamps
    end
  end
end
