class CreateGeneralProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :general_profiles do |t|
      t.text :kleshas
      t.timestamps
    end
  end
end
