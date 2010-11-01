class AddDataIntoUsersAndRoles < ActiveRecord::Migration
  def self.up
    User.create(:login => "admin_user1", :name => "Admin User1", :email => "Admin_User1@someaccount.com")
    User.create(:login => "admin_user2", :name => "Admin User2", :email => "Admin_User2@someaccount.com")
    User.create(:login => "admin_user3", :name => "Admin_User3", :email => "Admin_User3@someaccount.com")
    User.create(:login => "admin_user4", :name => "Admin User4", :email => "Admin_User4@someaccount.com")
    User.create(:login => "admin_user5", :name => "Admin User5", :email => "Admin_User5@someaccount.com")
    User.create(:login => "super_admin", :name => "Super Admin", :email => "Super_Admin@someaccount.com")
    Role.create(:name => "Admin")
    Role.create(:name => "SuperAdmin")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('1', '1')")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('1', '2')")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('1', '3')")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('1', '4')")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('1', '5')")
    execute("INSERT INTO roles_users(role_id, user_id) VALUES('2', '6')")
  end

  def self.down
  end
end
