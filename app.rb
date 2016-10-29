require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/database')
require_relative('./models/table')
require_relative('./controllers/controller')

require('pry-byebug')

# BEFORE
before do

  db = Database.new( 'money_cashboard' )
  merchants_table = db.table( 'merchants', 'name' )
  controllers = {}

  controllers['merchants'] = Controller.new( merchants_table )

  @path = request.path_info
  @path_root = @path[1..-1].split("/").first
  @controller = controllers[@path_root]

  if @controller.nil? && @path != '/page_not_found'
    @method = request.request_method
    redirect to('/page_not_found')
  end

end

# PAGE NOT FOUND
get '/page_not_found' do
  erb(:'partials/page_not_found')
end

# INDEX
get '/:table' do
  @data = @controller.index_data()
  erb(:index)
end

# NEW
get '/:table/new' do
  @data = @controller.new_data()
  erb(:new)
end

# CREATE
post '/:table' do
  @controller.create( params )
  redirect to( "/#{params[:table]}" )
end

# SHOW
get '/:table/:id' do
  @data = @controller.show_data( params[:id] )
  erb(:show )
end

# EDIT
get '/:table/:id/edit' do
end

# UPDATE
put '/:table/:id' do
end

# DESTROY
delete '/:table/:id' do
end
