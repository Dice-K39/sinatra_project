class GamerController < ApplicationController
    get '/signup' do
        if is_logged_in?
            redirect to '/video_games_index'
        else
            erb :'gamers/signup'
        end
    end

    post '/signup' do        
        if is_logged_in?
            redirect to '/video_games_index'
        else
            pw_confirmation = params[:confirm_password]
        
            params.delete(:confirm_password)
    
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
                if params[:password] == pw_confirmation
                    gamer.save
                    
                    session[:gamer_id] = gamer.id

                    @gamer = current_gamer
                   
                    redirect to '/video_games_index'
                else
                    flash[:non_matching_password] = "The password you have entered does not match. Please re-enter your password."
                    
                    redirect to '/signup'
                end
            end
        end
    end

    get '/login' do
        if is_logged_in?
            redirect to '/video_games_index'
        else
            erb :'gamers/login'
        end
    end

    post '/login' do
        gamer = Gamer.find_by(:username => params[:username], :email => params[:email])

        if gamer && gamer.authenticate(params[:password])
            session[:gamer_id] = gamer.id

            @gamer = gamer

            redirect to '/video_games_index'
        else
            if gamer
                flash[:password] = "Entered the wrong password. Please try again."

                redirect to '/login'
            else
                flash[:no_account] = "No account associated with username and email combination. Please create an account."

                redirect to '/signup'
            end
        end
    end

    get '/logout' do
        session.clear

        redirect to '/login'
    end

    delete '/gamer/:id' do
        gamer = Gamer.find_by_id(params[:id])

        gamer.destroy
        gamer.video_games.destroy_all

        session.clear

        redirect to '/'
    end
end