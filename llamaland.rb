require 'rubygems'
require 'sinatra'
require 'sequel'
require 'haml'

encoding_base = 36

configure do
    DB = Sequel.sqlite
    DB.create_table :urls do
        primary_key :id
        String :url
    end
end

get '/' do
    <<-EOS
    <form method="post">
        <input type="text" name="url" />
        <input type="submit" value="Shorten URL" />
    </form>
    EOS
end

get '/:shorturl' do
    redirect DB[:urls].first(:id => params[:shorturl].to_i(encoding_base))[:url]
end

post '/' do
    id = DB[:urls].insert(:url => params[:url])
    "#{request.url + id.to_s(encoding_base)}"
end
