require 'pry'
require_relative '../../config/environment'
require 'rack-flash'
require 'sinatra/base'

class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/posts/new' do
  	erb :new
  end

  get '/posts' do
  	@posts = Post.all
  	erb :index
  end

  post '/posts' do
  	@post = Post.create(params)
  	redirect to "/posts"
  end


  get '/posts/:id' do 
  	@post = Post.find_by_id(params[:id])
  	erb :show
  end

  get '/posts/:id/edit' do 
  	@post = Post.find_by_id(params[:id])
  	erb :edit
  end

  patch '/posts/:id' do
  	@post = Post.find_by_id(params[:id]) 
  	@post.save
  end

  post '/posts/:id' do
  	@post = Post.find_by_id(params[:id])
  	@post.name = params[:name]
  	@post.content = params[:content]
  	@post.save
  	erb :show
  end


  post '/posts' do 
  	erb :index
  end

  post '/posts/:id/delete' do
    binding.pry
  	@post = Post.find_by_id(params[:id])
  	@post.destroy
  	flash[:notice] = "#{@post.name} was deleted"
    redirect to '/posts'
  end


end