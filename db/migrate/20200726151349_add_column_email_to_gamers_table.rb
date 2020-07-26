class AddColumnEmailToGamersTable < ActiveRecord::Migration
  def change
    add_column :gamers, :email, :string
  end
end
