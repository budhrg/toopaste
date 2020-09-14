require 'sinatra'
require 'sinatra/activerecord'
require 'coderay'
require 'sinatra/reloader' if development?

set :database_file, 'config/database.yml'
set :bind, '0.0.0.0'

# Snippet class handle formatting code snippet
class Snippet < ActiveRecord::Base
  def formatted_body
    CodeRay.scan(body, :ruby).div(line_numbers: :table)
  end
end

# new
get '/' do
  erb :new
end

# create
post '/' do
  @snippet = Snippet.new(title: params[:snippet_title],
                        body: params[:snippet_body])
  if @snippet.save
    redirect "/#{@snippet.id}"
  else
    redirect '/'
  end
end

# show
get '/:id' do
  puts "========"
  puts params[:id]
  if params[:id].number?
    @snippet = Snippet.find(params[:id])
    if @snippet
      erb :show
    else
      redirect '/'
    end
  end
end

# Helper methods
class String
  def number?
    true if Float(self)
  rescue Exception
    false
  end
end
