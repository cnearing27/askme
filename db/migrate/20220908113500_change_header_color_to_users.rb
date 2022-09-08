class ChangeHeaderColorToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :header_color, :string, default: "#000000"
  end
end
