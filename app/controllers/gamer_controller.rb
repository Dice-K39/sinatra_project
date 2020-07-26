class GamerController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect to '/show_games'
        else
            erb :'gamers/signup'
        end
    end

    post '/signup' do        
        if is_logged_in?
            redirect to '/show_games'
        else
            pw_confirmation = params[:confirm_password]
        
            params.delete(:confirm_password)
    
            gamer = Gamer.new(params)

            EMAIL = /(?=\A.{6,255}\z)\A([a-z0-9]+[\w|\-|\.|\+]*)@([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63})/i

            if !params[:email].match(EMAIL)
                flash[:invalid_email] = "Email is invalid. Please re-enter your email."

                redirect to '/signup'
            elsif Gamer.find_by(:username => gamer[:username]) && Gamer.find_by(:email => gamer[:email])
                flash[:username_taken] = "The username and email combination is already in use. Please enter a new combination or login to continue."

                redirect to '/signup'
            else
                if params[:password] == pw_confirmation
                    gamer.save

                    session[:gamer_id] = gamer.id
                   
                    erb :'video_games/show_games'
                else
                    flash[:non_matching_password] = "The password you have entered does not match. Please re-enter your password."
                    
                    redirect to '/signup'
                end
            end
        end
    end

    get '/login' do
        if is_logged_in?
            redirect to '/show_games'
        else
            erb :'gamers/login'
        end
    end

    post '/login' do
        current_gamer = Gamer.find_by(:username => params[:username])

        if current_gamer && current_gamer.authenticate(params[:password])
            session[:gamer_id] = current_gamer.id

            redirect to '/show_games'
        else
            if current_gamer
                flash[:password] = "Entered the wrong password. Please try again."
            else
                flash[:no_account] = "No account associated with username. Please create an account."
            end
        end
    end
end