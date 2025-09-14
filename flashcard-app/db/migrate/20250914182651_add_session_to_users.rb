class AddSessionToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :session, :integer
  end
end
