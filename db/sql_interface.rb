require_relative('./sql_builder')
require_relative('./sql_runner')

class SqlInterface

  def self.select_all( db_name, table_name )
    sql = SqlBuilder.select_all_sql( table_name )
    result = SqlRunner.run( db_name, sql, true )
    return result
  end

end
