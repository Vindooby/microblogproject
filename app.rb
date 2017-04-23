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
	@users = User.all
	@posts = Post.all
	@posts = @posts.reverse
  erb :home
end

get "/profile" do
 if session[:user_id]
	 @user = User.find(session[:user_id])
	 @posts = @user.posts
	 @posts = @posts.reverse
   erb :profile
 else
	 erb :home
 end
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

post "/discover" do
	@users = User.all
	@search = params[:searchname]
	erb :discover_redir
end

post "/discover_results" do
	@searcheduser = User.where(username: params[:searcheduser]).first
	@posts = @searcheduser.posts
	@posts = @posts.reverse
	erb :discover_results
end

get "/users" do
	@users = User.all
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

get "/accountsettings" do
	@user = User.find(session[:user_id])
	erb :accountsettings
end

post "/accountsettings" do
	@user = User.find(session[:user_id])
	@user.update(fname: params[:fname], lname: params[:lname], email: params[:email], birthday: params[:bday], username: params[:username], password: params[:password], bio_content: params[:bio_content])
	redirect "/profile"
end

post "/deleteaccount" do
	@user = User.find(session[:user_id])
	@user.destroy
	@posts = Post.where(user_id: session[:user_id])
	@posts.each do |post|
		post.destroy
	end
	session[:user_id] = nil
	redirect "/"
end

get "/destroyall" do
	@users= User.all
	@posts= Post.all
	@users.each do |user|
		user.destroy
	end
	@posts.each do |post|
		post.destroy
	end
end
