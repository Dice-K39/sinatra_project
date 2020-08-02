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
            gamer = Gamer.find_by_id(session[:gamer_id])

            if gamer.video_games.find_by(:title => params[:title])
                binding.pry
                flash[:already_owned] = "You already own this game."

                redirect to '/video_games/new'
            else
                date_today = Date.today
                before_this_date = Date.new(1980,1,1)

                if params[:date_purchased] <= date_today.to_s && params[:date_purchased] >= before_this_date.to_s
                    @video_game = current_gamer.video_games.create(params)
                    
                    if @video_game.save
                        redirect to '/video_games'
                    else
                        flash[:not_saved] = "Error occured. Entry not saved."

                        redirect to '/video_games/new'
                    end
                else
                    flash[:date_not_possible] = "Date purchased not likely. Please enter today or date prior to today."

                    redirect to '/video_games/new'
                end
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