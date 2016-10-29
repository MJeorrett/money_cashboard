require_relative('../support/string__camel_to_title')

class Controller

  def initialize( table )
    @table = table
    @page_title = @table.name.camel_to_title
  end

  def index_data()

    table_data = @table.all()
    column_names = table_data.first.keys

    table_headers = column_names.map do |column_name|
      column_name.camel_to_title
    end

    data = {
      page_title: "#{@page_title} Index",
      table_data: table_data,
      table_headers: table_headers
    }

    return data

  end

  def new_data()
    column_data = @table.column_data
    return column_data
  end

  def show_data( id )

    record_data = @table.find_by_id( id )
    record_title = record_data[@table.title_column]

    data = {
      page_title: record_title,
      record_data: record_data
    }

  end

end
