class CreateGamers < ActiveRecord::Migration
  def change
    create_table :gamers do |t|
      t.string :username
      t.string :password_digest
    end
  end
end
