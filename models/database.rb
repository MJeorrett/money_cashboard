require_relative('./table')

class Database

  def initialize( db_name )
    @db_name = db_name
  end

  def table( table_name, name_column )
    return Table.new( @db_name, table_name, name_column )
  end

end
