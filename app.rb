require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"
set :sessions, true

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

post "/sign-up" do
    User.create(fname: params[:fname], lname: params[:lname], email: params[:email], birthday: params[:bday], username: params[:username], password: params[:password])
    redirect "/"
end

post "/sign-in" do
  @user = User.where(username: params[:username]).first
  if @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:alert] = "You have been signed in"
    redirect "/"
  else
    flash[:alert] = "Your name and password do not match"
    redirect "/login"
  end
end
# REDIR AFTER DISCOVER SEARCH
get "/discover_redir" do
  erb :discover_redir
end
