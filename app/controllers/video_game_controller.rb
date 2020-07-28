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

    get '/delete_account' do
        gamer = Gamer.find_by_id(session[:gamer_id])

        session.clear

        gamer.destroy
        gamer.video_games.destroy_all

        redirect to '/'
    end
end