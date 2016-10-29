require_relative('./table')

class Database

  SQL_TO_SIMPLE_TYPES = {
    'integer' => :int,
    'bigint' => :int,
    'smallint' => :int,
    'numeric' => :float,
    'character varying' => :string,
    'boolean' => :bool,
    'date' => :date
  }

  attr_reader :name

  def initialize( name )
    @name = name
  end

  def table( table_name, name_column )
    return Table.new( self, table_name, name_column )
  end

  def column_names_for_table( table )
    sql =
    "SELECT column_name FROM information_schema.columns
    WHERE table_name = '#{table.name}'"
    results = SqlRunner.run( @name, sql, true )
    results.map! { |result| result['column_name'] }
    return results
  end

  def columns_for_table( table )
    sql =
    "SELECT column_name, data_type
    FROM information_schema.columns
    WHERE table_name = '#{table.name}'"

    results = SqlRunner.run( @name, sql, true )

    results.map! do |result|

      reference_for_column = self.reference_for_column( table, result['column_name'] )

      if reference_for_column != nil

        result['ref_table'] = reference_for_column['ref_table']
        result['ref_column'] = reference_for_column['ref_column']
        simple_type = :ref

      else

        simple_type = Database.sql_to_simple_type( result['data_type'] )

      end

      result['data_type'] = simple_type
      result
    end

    return results
  end

  def reference_for_column( table, column_name )
    # query adapted from http://stackoverflow.com/questions/1152260/postgres-sql-to-list-table-foreign-keys
    sql =
    "SELECT
      ccu.table_name AS ref_table,
      ccu.column_name AS ref_column
    FROM
      information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
      JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
    WHERE
      tc.constraint_type = 'FOREIGN KEY'
      AND tc.table_name = '#{table.name}'
      AND kcu.column_name = '#{column_name}'"

    results = SqlRunner.run( @name, sql, true )
    return results.first
  end

  def self.sql_to_simple_type( sql_type_string )
    simple_type = SQL_TO_SIMPLE_TYPES[sql_type_string]
    return simple_type
  end

end
