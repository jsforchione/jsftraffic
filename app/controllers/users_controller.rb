get '/users' do 
  @users = User.all 
  erb :'users/index'
end 

get '/users/new' do 
  erb :'users/new'
end 

get '/users/:id/edit' do 
  @user = User.find(params[:id])
  erb :'users/edit'
end 

get '/users/:id' do 
  @user = User.find(params[:id])
  redirect '/sessions/new' unless current_user
  redirect '/questions' unless logged_in?
  erb :'/users/show'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user] = @user
    redirect "/users/#{@user.id}"
  else 
    @errors = ["Username or Email already exists"]
    redirect 'users/new'
  end
end

put '/users/:id' do
  @user = User.find(params[:id])
  if params[:password] == ""
    @user.update(email: params[:email], password_hash: @user.password_hash)
  else
    @user.update(email: params[:email], password: params[:password])
  end
  redirect "/users/#{@user.id}"
end

