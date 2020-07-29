class VideoGame < ActiveRecord::Base
    belongs_to :gamer

    validates :title, presence: true
    validates :developer, presence: true
    validates :date_purchased, presence: true
    validates :description, presence: true
end