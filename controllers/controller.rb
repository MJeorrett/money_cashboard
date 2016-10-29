require_relative('../support/string__camel_to_title')

class Controller

  def initialize( table )
    @table = table
    @table_title = @table.name.camel_to_title

    @record_title = @table_title
    @record_title = @table_title[0..-2] if @table_title[-1] == 's'
  end

  def index_data()
    table_data = @table.all()
    column_names = @table.column_names()

    table_headers = column_names.map do |column_name|
      column_name.camel_to_title
    end

    data = {
      table_title: @table_title,
      record_title: @record_title,
      table_data: table_data,
      table_headers: table_headers
    }

    return data
  end

  def new_data()
    columns_data = @table.columns_data

    data = {
      record_title: @record_title,
      columns_data: columns_data
    }

    return data
  end

  def create_record( data )
    @table.create_record( data )
  end

  def update_record( data )
    @table.update_record( data )
  end

  def show_data( id )
    record_data = @table.find_by_id( id )

    data = {
      page_title: record_data[@table.title_column],
      id: id,
      record_data: record_data
    }

    return data
  end

  def update_data( id )

      columns_data = @table.columns_data
      values_data = @table.find_by_id( id )

      data = {
        page_title: values_data[@table.title_column],
        id: id,
        columns_data: columns_data,
        values_data: values_data
      }

      return data
  end

  def delete_record( id )
    @table.delete_record( id )
  end

end
