post '/flags' do
  flag = Flag.new(user_id: request.cookies[:user_id])
  if flag.save
    "Success! Try a GET to /flags and make sure you're there"
  else
    status 401
    "Error! I couldn't create a flag, did you give me a cookie?"
  end
end

get '/flags' do
  flags = Flag.all
  erb :"flags/index", locals: {flags: flags}
end