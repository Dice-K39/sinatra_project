class RemoveColumnEmailFromGamersTable < ActiveRecord::Migration
  def change
    remove_column :gamers, :email
  end
end
