require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/database')
require_relative('./models/table')
require_relative('./controllers/controller')

require('pry-byebug')

starwars_db = Database.new( 'star_wars' )
jedis_table = starwars_db.table( 'jedis' )
controllers = {}

controllers['jedis'] = Controller.new( jedis_table )

# INDEX
get '/:table' do

  table = params[:table]
  controller = controllers[table]

  if controller.nil?
    @method = 'GET'
    @route = "/#{table}"
    erb_file = :'partials/page_not_found'
  else
    @data = controller.index_data()
    erb_file = :'index'
  end

  erb(erb_file)
end

# NEW
get '/:table/new' do
  table = params[:table]
  @method = 'GET'
  @route = "/#{table}/new"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end

# CREATE
post '/:table' do
  table = params[:table]
  @method = 'POST'
  @route = "/#{table}"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end

# SHOW
get '/:table/:id' do
  table = params[:table]
  @method = 'GET'
  @route = "/#{table}/:id"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end

# EDIT
get '/:table/:id/edit' do
  table = params[:table]
  @method = 'GET'
  @route = "/#{table}/:id/edit"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end

# UPDATE
put '/:table/:id' do
  table = params[:table]
  @method = 'put'
  @route = "/#{table}/:id"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end

# DESTROY
delete '/:table/:id' do
  table = params[:table]
  @method = 'DELETE'
  @route = "/#{table}/:id"
  erb_file = :'partials/page_not_found'
  erb(erb_file)
end
