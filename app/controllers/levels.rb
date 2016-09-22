# We are using an actual vanilla module here (not just relying
# on helpers) because helpers don't work in the route
# registration itself.

include PathHelpers

before "/levels/*", :agent => /^.+$/ do
  halt 400, erb(:'cheater')
end

# Welcome: Designed to be viewed in the browser
get "/" do
  erb :'welcome'
end

# Level 1: First try of a basic GET request
get level_path(1) do
  erb :'levels/level_1'
end

# Level 2: GET another rep in
get level_path(2) do
  erb :'levels/level_2'
end

# Level 3 expects a query parameter: ?secret=HellaTameableTransferProtocol
get level_path(3) do
  secret = params[:secret]
  if secret == LEVEL_3_SECRET
    erb :'levels/level_3'
  else
    status 403
    erb :'not_authorized'
  end
end

# Level 4 is a redirect with a custom response body
get level_path(4) do
  status 301
  headers "Location" => level_path(5)
  content_type :text
  erb :'levels/level_4', layout: false
end

# This is the 301 redirect Location header from level 4
get level_path(5) do
  erb :'levels/level_5'
end

# Level 6 has some 'splaining to do, so we suggested opening
# it in a browser for easier reading
get level_path(6) do
  erb :'levels/level_6'
end
