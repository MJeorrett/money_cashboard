require('minitest/autorun')
require('minitest/rg')
require('date')

require_relative('../sql_builder')

class SqlBuilderTest < MiniTest::Test

  def test_select_all()
    expected = "SELECT * FROM customers"
    actual = SqlBuilder.select_all_sql("customers")
    assert_equal(expected, actual)
  end

  def test_all_where_sql__multiple_conditions()
    expected = "SELECT * FROM customers WHERE first_name = 'Matthew' AND last_name = 'Jeorrett'"
    conditions = {
      first_name: "Matthew",
      last_name: "Jeorrett"
    }
    actual = SqlBuilder.all_where_sql("customers", conditions)
    assert_equal(expected, actual)
  end

  def test_all_where_sql__single_condition()
    expected = "SELECT * FROM customers WHERE id = 4"
    actual = SqlBuilder.all_where_sql("customers", { id: 4 })
    assert_equal(expected, actual)
  end

  def test_select_all_by_id_sql()
    expected = "SELECT * FROM customers WHERE id = 7"
    actual = SqlBuilder.select_all_by_id_sql( 'customers', 7 )
    assert_equal( expected, actual )
  end

  def test_insert_sql()
    expected = "INSERT INTO customers(first_name, last_name, funds) VALUES ('Matthew', 'Jeorrett', 14.99) RETURNING id"
    data = {
      first_name: "Matthew",
      last_name: "Jeorrett",
      funds: 14.99
    }
    actual = SqlBuilder.insert_sql("customers", data)
    assert_equal(expected, actual)
  end

  def test_delete_with_id_sql()
    expected = "DELETE FROM customers WHERE id = 4"
    actual = SqlBuilder.delete_with_id_sql("customers", 4)
    assert_equal(expected, actual)
  end

  def test_value_to_sql__string()
    assert_equal("'Matthew'", SqlBuilder.value_to_sql("Matthew"))
  end

  def test_value_to_sql__fixnum()
    assert_equal("14", SqlBuilder.value_to_sql(14))
  end

  def test_value_to_sql__float()
    assert_equal("14.33", SqlBuilder.value_to_sql(14.33))
  end

  def test_value_to_sql__trueclass()
    assert_equal( "TRUE", SqlBuilder.value_to_sql( true ) )
  end

  def test_value_to_sql__falseclass()
    assert_equal( "FALSE", SqlBuilder.value_to_sql( false ) )
  end

  def test_value_to_sql__nilclass()
    assert_equal( "NULL", SqlBuilder.value_to_sql( nil ))
  end

  def test_value_to_sql__dateclass()
    date = Date.parse("2016-10-10")
    assert_equal( "'2016-10-10'", SqlBuilder.value_to_sql( date ) )
  end

end
