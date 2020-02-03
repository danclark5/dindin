class AddPreferredTimezonetoUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :preferred_timezone, :string
    User.connection.execute("Update users set preferred_timezone = 'Eastern Time (US & Canada)'")
  end
end
