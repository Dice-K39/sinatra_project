class GamerController < ApplicationController
    get '/signup' do
        erb :'gamers/signup'
    end
end