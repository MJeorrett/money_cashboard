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
