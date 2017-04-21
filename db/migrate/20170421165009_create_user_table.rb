class CreateUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :birthday
      t.string :username
      t.string :password
      t.string :bio_content
    end
  end
end
