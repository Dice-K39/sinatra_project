class RemoveColumnProducerFromVideoGamesTable < ActiveRecord::Migration
  def change
    remove_column :video_games, :producer
  end
end
