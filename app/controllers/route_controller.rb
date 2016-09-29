get '/' do
  @title = 'Hello World!'
  erb :'routes/new'
end

get '/routes/index' do
  @params = params
  if @params[:destination].present? && @params[:origin].present?
    @routes = Route.where(:origin => params[:origin], :destination => params[:destination]).order(:duration_value)
  else
    @routes = Route.all
  end
  erb :'routes/index'
end

get '/routes/search' do
  erb :'routes/search'
end

post '/routes' do 
  @time = Time.new
  @hour = @time.hour
  @min = @time.min.to_s
  if @hour.to_int > 13
    @hour = @hour - 12
    @hour = @hour.to_s
    @min += ' pm'

  else
    @hour = @hour.to_s
    @min += ' am'
  end
  @humanReadableTime = "#{@hour}:#{@min}"
  @route = Route.new(:departure_time => @humanReadableTime, :origin => params[:origin],:destination => params[:destination], :duration_value => params[:duration_value], :duration_text => params[:duration_text], :distance_value => params[:distance_value], :distance_text => params[:distance_text])
  if @route.save
    redirect "routes/index"
  else
    p "ERROR!!"
  end
end

get '/routes/:id' do
   @route = Route.find(params[:id])
   if @route
    erb :'routes/show'
  else
    p "ERRRRRROR!!!"
  end
end