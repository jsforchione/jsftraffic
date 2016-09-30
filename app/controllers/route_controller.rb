get '/routes/new' do
  erb :'routes/new'
end

get '/routes/index' do
  @params = params

  if logged_in? == false
    erb :'/index'
  else
    if @params[:destination].present? && @params[:origin].present?
      routes = Route.where(:origin => params[:origin], :destination => params[:destination], :creator_id => current_user.id)
      @routes = routes.order(:duration_value)
      erb :'routes/index'
    else
      routes = Route.all.where(:creator_id => current_user.id)
      @routes = routes.order(:duration_value)
      erb :'routes/index'
    end
  end
  
end

get '/routes/search' do
  erb :'routes/search'
end

post '/routes' do

  @time = Time.now
  @hour = @time.hour
  @min = @time.min
  if @min < 10 
    @min = "0" + @min.to_s
  end 

  if @hour > 13
    @hour = @hour - 12
    @hour = @hour.to_s
    @min = @min.to_s
    @humanReadableTime = "#{@hour}:#{@min} PM"
  else 
    @hour = @hour.to_s
    @min = @min.to_s
    @humanReadableTime = "#{@hour}:#{@min} AM"
  end 

  @route = Route.new(:creator_id => current_user.id, :departure_time => @humanReadableTime, :origin => params[:origin],:destination => params[:destination], :duration_value => params[:duration_value], :duration_text => params[:duration_text], :distance_value => params[:distance_value], :distance_text => params[:distance_text])
  if @route.save
    redirect "routes/index"
  else
    p "ERROR!!"
  end
end

get '/routes/:id' do
   @route = Route.find(params[:id]).where(:creator_id => current_user.id)
   if @route
    erb :'routes/show'
  else
    erb :'routes/search'
  end
end