post '/users' do
  user = User.new(username: params[:username], password: params[:password])
  if user.save
    erb :"users/create_success", locals: {user: user}
  else
    status 400
    erb :"users/create_error", locals: {user: user}
  end
end

post '/users/login' do
  user = User.find_by(username: params[:username], password: params[:password])
  if user
    status 301
    headers "Location" => "/users/profile"
    response.set_cookie("user_id", :value => user.id)
    erb :"users/login_success", locals: {user: user}
  else
    status 401
    "Could not login. Bad username and password?"
  end
end

get '/users/profile' do
  user = User.find_by(id: request.cookies(:user_id))
  if user
    erb :"users/profile"
  else
    status 401
    "Cannot find user. Did you give me a cookie...?"
  end
end
