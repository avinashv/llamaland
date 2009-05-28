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
    <<-EOF
    <form method="post">
        <p>Enter a URL to shorten with the Llama Land URL Shortner:</p>
        <input type="text" name="url" />
        <input type="submit" value="Shorten URL" />
    </form>
    EOF
end
