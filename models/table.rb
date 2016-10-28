require_relative('../db/sql_interface')

class Table

  def initialize( db_name, table_name )
    @db_name = db_name
    @table_name = table_name
  end

  def self.all()

  end

end
