require_relative('../db/sql_interface')

class Table

  def initialize( db_name, table_name )
    @db_name = db_name
    @table_name = table_name
  end

  def all()
    result = SqlInterface.select_all( @db_name, @table_name )
    return result
  end

end
