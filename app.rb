require "sinatra"
require "sinatra/activerecord"

get "/" do
  erb :home
end

get "/profile" do
  erb :profile
end

get "/compose" do
  erb :compose
end

get "/discover" do
  erb :discover
end

get "/sign-in" do
  erb :signin
end

get "sign-up"
  erb :signup
