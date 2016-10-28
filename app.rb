require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/database')
require_relative('./models/table')
require_relative('./controllers/controller')

require('pry-byebug')

starwars_db = Database.new( 'star_wars' )
jedis_table = starwars_db.table( 'jedis' )

# Controller.create_index( '/jedis', jedis_table, 'Jedis Index')

get '/jedis' do
  @table_data = jedis_table.all()
  @table_headers = @table_data.first.keys
  @page_title = "Jedis Index"
  erb(:index)
end
