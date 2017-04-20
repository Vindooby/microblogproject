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

get "/login" do
  erb :signin
end

get "/signup" do
  erb :signup
end

# REDIR AFTER DISCOVER SEARCH
get "/discover_redir" do
  erb :discover_redir
end
