class DropHashtagsQuestions < ActiveRecord::Migration[7.0]
  def change
    drop_table :hashtags_questions
  end
end
