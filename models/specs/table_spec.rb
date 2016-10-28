require('minitest/autorun')
require('minitest/rg')

require_relative('../table')

class TableTest < MiniTest::Test

  def setup()
    @jedis_table = Table.new( "star_wars", "jedis" )
  end

  def test_has_table_name()
    assert_equal( "jedis", @jedis_table.name )
  end

end
