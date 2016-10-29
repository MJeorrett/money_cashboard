require_relative('../db/sql_interface')

class Table

  attr_reader :name, :title_column

  def initialize( database, name, title_column )
    @database = database
    @name = name
    @title_column = title_column
  end

  def all()
    result = SqlInterface.select_all( @database.name, @name )
    return result
  end

  def find_by_id( id )
    result = SqlInterface.select_all_by_id( @database.name, @name, id )
    return result
  end

  def column_data()
    @database.columns_for_table( self )
  end

end
