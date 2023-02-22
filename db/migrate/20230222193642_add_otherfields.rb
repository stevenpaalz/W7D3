class AddOtherfields < ActiveRecord::Migration[7.0]
  def change

    add_column :users, :password_digest, :string
    add_column :users, :session_token, :string
    add_index :users, :session_token, unique: true
  end
end
