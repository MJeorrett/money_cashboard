require_relative('../support/string__camel_to_title')

class Controller

  def initialize( table )
    @table = table
    @page_title = @table.name.camel_to_title
  end

  def index_data()

    table_data = @table.all()
    column_names = table_data.first.keys

    table_headers = column_names.map! do |column_name|
      column_name.camel_to_title
    end

    data = {
      table_data: table_data,
      table_headers: table_headers,
      page_title: "#{@page_title} Index"
    }

    return data

  end

  def show_data( id )

    record_data = @table.find_by_id( id )

    data = {
      page_title: "Show record #{id}",
      record_data: record_data
    }

  end

end
