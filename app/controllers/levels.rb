require_relative '../helpers/level_names'

include LevelNames

get level_path(0) do
  erb :'welcome'
end

get level_path(1) do
  erb :'level_1'
end

get level_path(2) do
  erb :'level_2'
end

get level_path(3) do
  erb :'level_3'
end

get level_path(4) do
  status 301
  headers "Location" => "/whatsgoingon"
  content_type :text
  erb :'level_4', layout: false
end

get level_path(5) do
  erb :'level_5'
end

get '/whatsgoingon' do
  erb :'level_4_bounce'
end