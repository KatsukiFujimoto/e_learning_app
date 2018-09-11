class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :action_type
      t.integer :passive_user_id
      t.integer :answer_count
      t.integer :count
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :activities, :passive_user_id
  end
end
