class SwitchFromIsAdminToUserType < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_type, :string, null: false, default: 'free'
    User.connection.execute("Update users set user_type = 'free'")
    remove_column :users, :is_admin
  end
end
