class VideoGameController < ApplicationController
    get '/video_games' do
        if !is_logged_in?
            redirect to '/login'
        else        
            @gamer = current_gamer

            erb :'video_games/index'
        end
    end

    get '/video_games/new' do
        if !is_logged_in?
            redirect to '/login'
        else        
            erb :'video_games/new'
        end
    end

    post '/video_games' do
        if !is_logged_in?
            redirect to '/login'
        else        
            @video_game = current_gamer.video_games.create(params)
            
            if @video_game.save
                redirect to '/video_games'
            else
                redirect to '/video_games/new'
            end
        end
    end

    get '/video_games/:id' do
        if !is_logged_in?
            redirect to '/login'
        else        
            @video_game = VideoGame.find_by_id(params[:id])

            erb :'video_games/show'
        end
    end

    get '/video_games/:id/edit' do
        if !is_logged_in?
            redirect to '/login'
        else        
            @video_game = VideoGame.find_by_id(params[:id])

            erb :'video_games/edit'
        end
    end

    patch '/video_games/:id' do
        if !is_logged_in?
            redirect to '/login'
        else        
            video_game = VideoGame.find_by_id(params[:id])

            params.delete(:_method)

            video_game.update(params)

            redirect to '/video_games'
        end
    end

    delete '/video_games/:id' do
        if !is_logged_in?
            redirect to '/login'
        else        
            VideoGame.delete(params[:id])
            
            redirect to '/video_games'
        end
    end
end