require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.order(:name)
  erb :'meetups/index'
end

get '/meetups/new' do
  erb :'meetups/new'
end

post '/meetups/new' do
  name = params['name']
  location = params['location']
  description = params['description']
  id = params['id']

  @meetup = Meetup.new(name: name, location: location, description: description, creator: "Nick")

    if @meetup.save
      flash[:notice] = "You have created an event."
      redirect "/meetups/#{@meetup.id}"

    else
      flash[:notice] = "Please fill out form completely"
      erb:'/meetups/new'
    end
end

get '/meetups/:id' do
  @meetup = Meetup.all.find(params[:id])
  @usermeetups = Usermeetup.all
  @attendees = []
  @usermeetups.each do |usermeetup|
    if usermeetup.meetup_id == params[:id].to_i
      @attendees << usermeetup.user
    end
  end
  erb :'meetups/show'
end

get '/meetups/:id/join' do
  @meetup = Meetup.all.find(params[:id])
  @current_user = current_user

  if @current_user.nil?
    flash[:notice] = "You must sign in first to join this meetup"
  else
    @usermeetup = Usermeetup.new(user_id: @current_user.id, meetup_id: @meetup.id)
    if @usermeetup.save
      flash[:notice] = "You have successfully joined this meetup"
      redirect "/meetups/#{@meetup.id}"
    end
  end

  redirect "/meetups/#{@meetup.id}"
end
