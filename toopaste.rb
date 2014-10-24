require 'sinatra'
require 'sinatra/activerecord'
require 'coderay'

set :database, 'sqlite3:db/development.sqlite3'

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
  @snippet = Snippet.find(params[:id])
  if @snippet
    erb :show
  else
    redirect '/'
  end
end
