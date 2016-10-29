require('date')

class SqlBuilder

  def self.select_all_sql( table_name )
    return "SELECT * FROM #{table_name}"
  end

  def self.all_where_sql( table_name, conditions )
    select_statement = self.select_all_sql(table_name)
    where_clause = self.where_clause( conditions )

    return "#{select_statement} #{where_clause}"
  end

  def self.select_all_by_id_sql( table_name, id )
    conditions = { id: id }
    sql = self.all_where_sql( table_name, conditions )
    return sql
  end

  def self.insert_sql( table_name, values_hash )

    sql_arrays = self.get_columns_and_values( values_hash )

    columns_sql = sql_arrays[:columns_array].join(", ")
    values_sql = sql_arrays[:values_array].join(", ")

    return "INSERT INTO #{table_name}(#{columns_sql}) VALUES (#{values_sql}) RETURNING id"
  end

  def self.where_clause( conditions )
    conditions_array = []

    for column, value in conditions
      value_sql = self.value_to_sql(value)
      sql = "#{column} = #{value_sql}"
      conditions_array.push(sql)
    end

    conditions_sql = conditions_array.join(" AND ")

    return "WHERE #{conditions_sql}"
  end

  def self.get_columns_and_values( values_hash )
    columns_array = []
    values_array = []

    for column, value in values_hash
      columns_array.push(column)
      value_sql = self.value_to_sql( value )
      values_array.push( value_sql )
    end

    return {
      columns_array: columns_array,
      values_array: values_array
    }
  end

  def self.value_to_sql( value )
    value_class = value.class().to_s()

    case value_class

    when 'Fixnum'
      sql = "#{value}"

    when 'Float'
      sql = "#{value}"

    when 'String'
      sql = "'#{value.gsub("'", "''")}'"

    when 'TrueClass'
      sql = "TRUE"

    when 'FalseClass'
      sql = "FALSE"

    when 'NilClass'
      sql = "NULL"

    when 'Date'
      sql = "'#{value}'"

    else
      raise(TypeError, "Un-supported data type class: #{value_class}.")
    end

    return sql
  end

end
