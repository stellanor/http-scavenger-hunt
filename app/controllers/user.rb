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
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    response.set_cookie("user_id", :value => user.id)
  else
    status 401
    "error"
  end
end
