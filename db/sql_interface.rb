require_relative('./sql_builder')
require_relative('./sql_runner')

class SqlInterface

  def select_all( db_name, table_name )
    sql = SqlBuilder.select_all_sql( table_name )
    result = SqlRunner.run( db_name, sql )
    return result
  end

end
