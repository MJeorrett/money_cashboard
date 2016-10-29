require_relative('./sql_builder')
require_relative('./sql_runner')

class SqlInterface

  def self.select_all( db_name, table_name )
    sql = SqlBuilder.select_all_sql( table_name )
    results = SqlRunner.run( db_name, sql, true )
    return results
  end

  def self.select_all_where( db_name, table_name, conditions )
    sql = SqlBuilder.select_all_where_sql( table_name, conditions )
    results = SqlRunner.run( db_name, sql, true )
    return results
  end

  def self.select_all_by_id( db_name, table_name, id )
    sql = SqlBuilder.select_all_by_id_sql( table_name, id )
    results = SqlRunner.run( db_name, sql, true )
    result = results.first
    return result
  end

  def self.insert( db_name, table_name, values_hash )
    sql = SqlBuilder.insert_sql( table_name, values_hash )
    return SqlRunner.run( db_name, sql, true ).first()['id']
  end

end
