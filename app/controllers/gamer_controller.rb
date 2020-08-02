class GamerController < ApplicationController
    get '/signup' do
        if_logged_in_redirect_to_video_games

        erb :'gamers/signup'
    end

    post '/signup' do        
        if_logged_in_redirect_to_video_games

        gamer = Gamer.new(params)

        # Does not follow RFC 5322. Not able to validate internationalized emails or TLD emails.
        EMAIL = /(?=\A.{6,255}\z)\A([a-z0-9]+[\w|\-|\.|\+]*)@([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63})/i

        if !params[:email].match(EMAIL)
            flash[:invalid_email] = "Email is invalid. Please re-enter your email."

            redirect to '/signup'
        elsif Gamer.find_by(:username => gamer[:username]) && Gamer.find_by(:email => gamer[:email])
            flash[:username_taken] = "The username and email combination is already in use. Please enter a new combination or login to continue."

            redirect to '/signup'
        else
            if params[:password] != params[:password_confirmation]
                flash[:password_not_the_same] = "Password and password confirmation not the same. Please check your entry."

                redirect to '/signup'
            else
                if params[:password].split("").count < 5
                    
                    flash[:password_short] = "Password is too short. Re-enter a longer password."

                    redirect to '/signup'
                else
                    gamer.save
                    
                    session[:gamer_id] = gamer.id

                    @gamer = current_gamer
                    
                    redirect to '/video_games'
                end
            end
        end
    end

    get '/login' do
        if_logged_in_redirect_to_video_games

        erb :'gamers/login'
    end

    post '/login' do
        gamer = Gamer.find_by(:username => params[:username], :email => params[:email])

        if params[:password].split("").count < 5
                    
            flash[:password_short] = "Password is too short. Re-enter your password."

            redirect to '/login'
        else
            if gamer && gamer.authenticate(params[:password])
                session[:gamer_id] = gamer.id

                @gamer = gamer

                redirect to '/video_games'
            else
                if gamer
                    flash[:password] = "Entered incorrect password. Please try again."

                    redirect to '/login'
                else
                    flash[:no_account] = "No account associated with username and email combination. Please create an account."

                    redirect to '/signup'
                end
            end
        end
    end

    get '/logout' do
        session.clear

        redirect to '/login'
    end
end