class SqlBuilder

  def self.select_all_sql( table_name )
    return "SELECT * FROM #{table_name}"
  end

end
