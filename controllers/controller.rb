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
    column_names = table_data.first.keys

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
    column_data = @table.column_data

    data = {
      record_title: @record_title,
      column_data: column_data
    }

    return data
  end

  def show_data( id )

    record_data = @table.find_by_id( id )

    data = {
      page_title: record_data[@table.title_column],
      record_data: record_data
    }

    return data

  end

end
