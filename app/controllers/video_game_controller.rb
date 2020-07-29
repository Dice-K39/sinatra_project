class VideoGameController < ApplicationController
    get '/video_games_index' do
        @gamer = current_gamer

        erb :'video_games/video_games_index'
    end

    get '/new' do
        erb :'video_games/new'
    end

    post '/new' do
        @video_game = current_gamer.video_games.create(params)
        
        if @video_game.save
            redirect to '/video_games_index'
        else
            redirect to '/new'
        end
    end

    delete '/video_games/:id' do
        VideoGame.delete(params[:id])
        
        redirect to '/video_games_index'
    end
end