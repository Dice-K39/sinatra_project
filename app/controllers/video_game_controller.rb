class VideoGameController < ApplicationController
    get '/gamer_home' do
        @gamer = current_gamer

        erb :'video_games/gamer_home'
    end

    get '/new' do
        erb :'video_games/new'
    end

    post '/new' do
        @video_game = current_gamer.video_games.create(params)
        
        if @video_game.save
            redirect to '/gamer_home'
        else
            redirect to '/new'
        end
    end
end