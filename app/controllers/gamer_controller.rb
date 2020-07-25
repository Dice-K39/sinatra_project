class GamerController < ApplicationController
    get '/signup' do
        erb :'gamers/signup'
    end

    post '/signup' do
        erb :'video_games/show'
    end
end