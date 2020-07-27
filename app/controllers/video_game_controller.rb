class VideoGameController < ApplicationController
    get '/video_games/index' do
        @gamer = current_gamer

        erb :'/video_games/index'
    end
end