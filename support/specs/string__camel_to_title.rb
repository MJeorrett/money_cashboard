require('minitest/autorun')
require('minitest/rg')

require_relative('../string__camel_to_title')

class StringCamelToTitleTest < MiniTest::Test

  def test_single_word()
    assert_equal( "Banana", "banana".camel_to_title )
  end

  def test_multiple_words()
    assert_equal( "There Was A Banana", "there_was_a_banana".camel_to_title )
  end

end
