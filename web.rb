require 'rubygems'
require 'sinatra'
require 'json'
require_relative 'models/disassembler'

get '/' do
  erb :index
end

post '/?' do
  begin
    json = JSON.parse request.body.read 
    code = json['code']
    @diss = Disassembler.disassemble code
  rescue => e
    logger.error "Error encountered while trying to dissassemble code"
    logger.error e
    @diss = e.message
  end
  erb :diss, :layout => false
end
