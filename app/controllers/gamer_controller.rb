class GamerController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect to '/show_games'
        else
            erb :'gamers/signup'
        end
    end

    post '/signup' do
        pw_confirmation = params[:confirm_password]
        
        params.delete(:confirm_password)

        gamer = Gamer.new(params)
        
        if is_logged_in?
            redirect to '/show_games'
        else
            if Gamer.find_by(:username => gamer[:username])
                flash[:username_taken] = "The username is already in use. Please enter a new username or log in to continue."

                redirect to '/signup'
            else
                if params[:password] == pw_confirmation
                    gamer.save

                    session[:gamer_id] = gamer.id
                    binding.pry
                    erb :'video_games/show_games'
                else
                    flash[:non_matching_password] = "The password you have entered does not match. Please re-enter your password."
                    
                    redirect to '/signup'
                end
            end
        end
    end

    get '/login' do
        erb :'gamers/login'
    end

    post '/login' do

    end
end