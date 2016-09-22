# Level names are in a module so that we can provide
# path helper functions to the templates, and also so that
# cryptic level names like 'quatro' and 'iii' are not so
# hard to read in here.
#
# We are using an actual vanilla module here (not just relying
# on helpers) because helpers don't work in the route
# registration itself.

require_relative '../helpers/level_names'

include LevelNames

before "/levels/*", :agent => /^.+$/ do
  halt 400, erb(:'cheater')
end

# Welcome: Designed to be viewed in the browser
get level_path(0) do
  erb :'welcome'
end

# Level 1: First try of a basic GET request
get level_path(1) do
  erb :'level_1'
end

# Level 2: GET another rep in
get level_path(2) do
  erb :'level_2'
end

# Level 3 expects a query parameter: ?secret=HellaTameableTransferProtocol
get level_path(3) do
  secret = params[:secret]
  if secret == "HellaTameableTransferProtocol"
    erb :'level_3'
  else
    status 403
    erb :'not_authorized'
  end
end

# Level 4 is a redirect with a custom response body
get level_path(4) do
  status 301
  headers "Location" => "/whatsgoingon"
  content_type :text
  erb :'level_4', layout: false
end

# This is the 301 redirect Location header from level 4
get '/whatsgoingon' do
  erb :'level_4_bounce'
end

# Level 5 has some 'splaining to do, so we suggested opening
# it in a browser for easier reading
get level_path(5) do
  erb :'level_5'
end

# TODO: Level 6 -- requires session / cookies

# TODO: Level 7 -- PUT user

get '/the-end' do
  erb :'end'
end
