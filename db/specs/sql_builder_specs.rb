require('minitest/autorun')
require('minitest/rg')

require_relative('../sql_builder')

class SqlBuilderTest < MiniTest::Test

  def test_select_all()
    expected = "SELECT * FROM customers"
    actual = SqlBuilder.select_all_sql("customers")
    assert_equal(expected, actual)
  end

end
