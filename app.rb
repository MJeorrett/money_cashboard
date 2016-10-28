require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/database')
require_relative('./models/table')
require_relative('./controllers/controller')

require('pry-byebug')

# BEFORE
before do

  starwars_db = Database.new( 'star_wars' )
  jedis_table = starwars_db.table( 'jedis' )
  controllers = {}

  controllers['jedis'] = Controller.new( jedis_table )

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
end

# CREATE
post '/:table' do
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
