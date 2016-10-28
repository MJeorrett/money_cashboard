require('date')

class SqlBuilder

  def self.select_all_sql( table_name )
    return "SELECT * FROM #{table_name}"
  end

  def self.all_where_sql( table_name, conditions_hash )
    select_statement = self.select_all_sql(table_name)
    where_clause = self.where_clause( conditions_hash )

    return "#{select_statement} #{where_clause}"
  end

  def self.all_where_id_sql( table_name, id )
    conditions_hash = { id: id }
    sql = self.all_where_sql( table_name, conditions_hash )
    return sql
  end

  def self.where_clause( conditions_hash )
    conditions_array = []

    for column, value in conditions_hash
      value_sql = self.value_to_sql(value)
      sql = "#{column} = #{value_sql}"
      conditions_array.push(sql)
    end

    conditions_sql = conditions_array.join(" AND ")

    return "WHERE #{conditions_sql}"
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
