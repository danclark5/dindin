class AddIsAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_admin, :boolean, null: false, default: false
    User.connection.execute("Update users set is_admin = false")
  end
end
