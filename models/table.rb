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

  def columns_data()
    columns_data_arr = @database.columns_for_table( self )
    return columns_data_arr
  end

  def column_names()
    column_names_arr = @database.column_names_for_table( self )
    return column_names_arr
  end

  def create_record( data )
    column_names = self.column_names()

    values_hash = data.select do |key, value|
        column_names.include?( key )
    end

    id = SqlInterface.insert( @database.name, @name, values_hash )
  end

end
