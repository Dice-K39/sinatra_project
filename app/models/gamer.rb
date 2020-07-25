class Gamer < ActiveRecord::Base
    has_secure_password
    has_many :video_games

    validates :username, presence: true, uniqueness: true
end