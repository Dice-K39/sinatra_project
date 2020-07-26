require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    erb :index
  end

  helpers do
    def is_logged_in?
      !!current_gamer
    end

    def current_gamer
      @current_gamer ||= Gamer.find_by(id: session[:gamer_id]) if session[:gamer_id]
    end
  end
end
