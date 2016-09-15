def l(str)
  '/levels/' + str
end

level_routes = [
  '/',
  l("one"),
  l("2"),
  l("iii"),
  l("quatro"),
  l("00000101")
]

get level_routes[0] do
  erb :'welcome'
end

get level_routes[1] do
end

get level_routes[2] do
end

get level_routes[3] do
end

get level_routes[4] do
end

get level_routes[5] do
end

get '/whatsgoingon' do

end