require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do
    erb :index
  end

  helpers do
    def is_logged_in?
      !!current_gamer
    end

    def current_gamer
      @current_gamer ||= Gamer.find_by(id: session[:gamer_id]) if session[:gamer_id]
    end

    def if_logged_in_redirect_to_video_games
      if is_logged_in?
        redirect to '/video_games'
      end
    end

    def if_not_logged_in_redirect_to_login
      if !is_logged_in?
        redirect to '/login'
      end
    end

    def redirect_if_not_game_owner(id)
      if current_gamer.id != id
        flash[:cannot_edit_other_gamers_game] = "Error! ERROR!!!."

        redirect to '/video_games'
      end
    end
  end
end
