require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"
set :sessions, true

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

get "/" do
  erb :home
end

get "/profile" do
	 @user = User.find(session[:user_id])
	 @posts = @user.posts
  erb :profile
end

get "/compose" do
  erb :compose
end

post "/compose" do
  @user= User.find(session[:user_id])
  @user.posts << Post.create(title: params[:title], content: params[:content], user_id: @user.id)
  redirect "/profile"
end

get "/discover" do
  erb :discover
end
get "/users" do
  erb :users
end
get "/login" do
  erb :signin
end

get "/signout" do
	session[:user_id] = nil
  redirect "/"
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

get "/discover_redir" do
  erb :discover_redir
end
