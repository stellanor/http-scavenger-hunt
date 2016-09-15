require_relative 'level_names'

include LevelNames

get level_path(0) do
  erb :'welcome'
end

get level_path(1) do
end

get level_path(2) do
end

get level_path(3) do
end

get level_path(4) do
end

get level_path(5) do
end

get '/whatsgoingon' do

end