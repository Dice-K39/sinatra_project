class CreateVideoGames < ActiveRecord::Migration
  def change
    create_table :video_games do |t|
      t.string :title
      t.string :developer
      t.string :producer
      t.date :release_date
      t.string :description
      t.integer :gamer_id
    end
  end
end
