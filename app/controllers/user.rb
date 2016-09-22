# We are using an actual vanilla module here (not just relying
# on helpers) because helpers don't work in the route
# registration itself.

include PathHelpers

post user_create_path do
  user = User.new(username: params[:username], password: params[:password])
  if user.save
    erb :"users/create_success", locals: {user: user}
  else
    status 422
    erb :"users/create_error", locals: {user: user}
  end
end

post user_login_path do
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

get user_profile_path do
  user = User.find_by(id: request.cookies['user_id'])
  if user
    erb :"users/profile", locals: {user: user}
  else
    status 401
    "Cannot find user. Did you give me a cookie...?"
  end
end
