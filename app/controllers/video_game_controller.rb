class VideoGameController < ApplicationController
    get '/video_games' do
        @gamer = current_gamer

        erb :'video_games/index'
    end

    get '/video_games/new' do
        erb :'video_games/new'
    end

    post '/video_games' do
        @video_game = current_gamer.video_games.create(params)
        
        if @video_game.save
            redirect to '/video_games'
        else
            redirect to '/video_games/new'
        end
    end

    get '/video_games/:id' do
        @video_game = VideoGame.find_by_id(params[:id])

        erb :'video_games/show'
    end

    get '/video_games/:id/edit' do
        @video_game = VideoGame.find_by_id(params[:id])

        erb :'video_games/edit'
    end

    patch '/video_games/:id' do
        video_game = VideoGame.find_by_id(params[:id])

        params.delete(:_method)

        video_game.update(params)

        redirect to '/video_games'
    end

    delete '/video_games/:id' do
        VideoGame.delete(params[:id])
        
        redirect to '/video_games'
    end
end