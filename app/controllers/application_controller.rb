
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  post '/posts' do
    @post = Post.new(name: params[:name], content: params[:content])
    if @post.save
      redirect '/posts'
    else
      erb :new
    end
  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update({name: params[:name], content: params[:content]})
    redirect to "/posts/#{@post.id}"
  end

end
