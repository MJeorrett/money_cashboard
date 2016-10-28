require_relative('../db/sql_interface')

class Table

  attr_reader :name, :title_column

  def initialize( db_name, name, title_column )
    @db_name = db_name
    @name = name
    @title_column = title_column
  end

  def all()
    result = SqlInterface.select_all( @db_name, @name )
    return result
  end

  def find_by_id( id )
    result = SqlInterface.select_all_by_id( @db_name, @name, id )
    return result
  end

end
