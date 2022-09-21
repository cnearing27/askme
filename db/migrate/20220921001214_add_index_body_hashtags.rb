class AddIndexBodyHashtags < ActiveRecord::Migration[7.0]
  def change
    add_index :hashtags, :body, unique: true
  end
end
