class CreateHashtagQuestion < ActiveRecord::Migration[7.0]
  def change
    create_table :hashtag_questions do |t|
      t.belongs_to :hashtag, null: false, foreign_key: true
      t.belongs_to :question, null: false, foreign_key: true
      t.index %i[hashtag_id question_id], unique: true

      t.timestamps
    end
  end
end
