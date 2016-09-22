post '/users' do
  user = User.new(username: params[:username], password: params[:password])
  if user.save
    erb :"users/create_success", locals: {user: user}
  else
    status 400
    erb :"users/create_error", locals: {user: user}
  end
end