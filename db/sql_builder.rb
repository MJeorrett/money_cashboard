class SqlBuilder

  def self.all_records_sql( table_name )
    return "SELECT * FROM #{table_name}"
  end

end
