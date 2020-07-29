class RenameColumnReleaseDateToDatePurchasedInVideoGamesTable < ActiveRecord::Migration
  def change
    rename_column :video_games, :release_date, :date_purchased
  end
end
