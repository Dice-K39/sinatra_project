class GamerController < ApplicationController
    get '/signup' do
        erb :'gamers/signup'
    end

    post '/signup' do
        pw_confirmation = params[:confirm_password]
        
        params.delete(:confirm_password)

        gamer = Gamer.new(params)
        

        if Gamer.find_by(:username => gamer[:username])
            flash[:username_taken] = "The username is already in use. Please enter a new username or log in to continue."

            redirect to '/signup'
        else
            if params[:password] == pw_confirmation
                Gamer.create(params)
            else
                flash[:non_matching_password] = "The password you have entered does not match. Please re-enter your password."
                
                redirect to '/signup'
            end
        end

        erb :'video_games/show'
    end
end