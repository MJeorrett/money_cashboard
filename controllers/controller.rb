require('sinatra')

class Controller

  def initialize( table )
    @table = table
  end

  def self.create_index( path, table, page_title )
    get( path ) do
      @table_data = model.all()
      @table_headers = table_data.first.keys
      @page_title = table.
      erb(:index)
    end
  end

end
