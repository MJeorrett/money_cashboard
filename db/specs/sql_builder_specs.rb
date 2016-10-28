require('minitest/autorun')
require('minitest/rg')

require_relative('../sql_builder')

class SqlBuilderTest < MiniTest::Test

  def test_all_records_sql()
    expected = "SELECT * FROM customers"
    actual = SqlBuilder.all_records_sql("customers")
    assert_equal(expected, actual)
  end

end
