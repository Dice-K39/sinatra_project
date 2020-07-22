class VideoGame < ActiveRecord::Base
    belongs_to :gamer

    validates :title, presence: true
    validates :developer, presence: true
    validates :producer, presence: true
    validates :description, presence: true
end