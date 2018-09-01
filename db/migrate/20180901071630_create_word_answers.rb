class CreateWordAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :word_answers do |t|
      t.string :content
      t.boolean :correct, default: false
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
