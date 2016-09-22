# We are using an actual vanilla module here (not just relying
# on helpers) because helpers don't work in the route
# registration itself.

include LevelNames

post flags_path do
  uid = request.cookies["user_id"]
  user = User.find_by(id: uid)
  flag = Flag.new(user_id: uid)
  if user && flag.save
    "Success! Try a GET to #{flags_path} and make sure you're there"
  else
    status 401
    "Error! I couldn't create a flag, did you give me a cookie?"
  end
end

get flags_path do
  flags = Flag.all
  erb :"flags/index", locals: {flags: flags}
end