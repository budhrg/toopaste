require 'sinatra'
require 'sinatra/activerecord'
require 'rouge'
require 'sinatra/reloader' if development?

if development?
  set :database_file, 'config/database.yml'
else
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end

set :bind, '0.0.0.0'

# Snippet class handle formatting code snippet
class Snippet < ActiveRecord::Base
  def formatted_body
    # https://github.com/jekyll/jekyll/blob/f4ee82650efebb2d37acf3493398f0e4e99b31b3/lib/jekyll/tags/highlight.rb#L83
    formatter = ::Rouge::Formatters::HTMLLegacy.new(
      line_numbers: true,
      wrap: false,
      css_class: 'highlight',
      gutter_class: 'gutter',
      code_class: 'code'
    )
    lexer = Rouge::Lexer.find_fancy(lang, body)
    output = formatter.format(lexer.lex(body))
    add_code_tag(output, lang)
  end

  def add_code_tag(code, lang)
    code_attributes = [
      "class=\"language-#{lang.to_s.tr('+', '-')}\"",
      "data-lang=\"#{lang}\""
    ].join(' ')
    "<figure class=\"highlight\"><pre><code #{code_attributes}>"\
    "#{code.chomp}</code></pre></figure>"
  end
end

# list all snipeets
get '/all' do
  @snippets = Snippet.all
  puts @snippets.length
  erb :all
end

# new
get '/' do
  erb :new
end

# create
post '/' do
  @snippet = Snippet.new(title: params[:snippet_title],
                        body: params[:snippet_body], lang: params[:snippet_lang])
  if @snippet.save
    redirect "/#{@snippet.id}"
  else
    redirect '/'
  end
end

# show
get '/:id' do
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
