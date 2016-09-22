post '/users' do
  user = User.new(username: params[:username], password: params[:password])
  if user.save
    # TODO: Respond with Level 6 route
    200
  else
    400
    erb :"users/create_error", locals: {user: user}
  end
end