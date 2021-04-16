class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :plan_id

      t.timestamps
    end
  end
end
