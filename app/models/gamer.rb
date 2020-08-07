class Gamer < ActiveRecord::Base
    has_secure_password
    has_many :video_games

    validates :username, presence: true, uniqueness: true
    #validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 5} # don't need presence
end