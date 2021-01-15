require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    assert_equal true, symbol1 == symbol2
    assert_equal false, symbol1 == symbol3
  end

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    assert_equal true, symbol1           == symbol2
    assert_equal true, symbol1.object_id == symbol2.object_id ## 回想 String 部分，也有一道类似的题，比较一下
  end

  def test_method_names_become_symbols
    ## Symbol.all_symbols 返回所有的 Symbol 对象
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?
  ## 答：如果不转化，则：
  ## Symbol.all_symbols.include?(:test_method_names_become_symbols)
  ## 这句代码中，出现了 :test_method_names_become_symbols 这个 Symbol 对象
  ## 那么这个时候，这个 Symbol 对象就有可能（没错，有可能，依 ruby 版本而不同）已经存在
  ## 这是再判断它存不存在，就没意义了
  ## 一个通俗的例子：你在一个房间里，想看看这个房间里有没有小明
  ## 但是呢，你不认识小明
  ## 所以，你先把小明叫到这个房间里，再把这个房间里的所有人跟这个小明比较
  ## 你说，能得出正确结果吗

  in_ruby_version("mri") do
    RubyConstant = "What is the sound of one hand clapping?"
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

      assert_equal true, all_symbols_as_strings.include?('RubyConstant')
    end
  end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    assert_equal :catsAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal "cats and dogs".to_sym, symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal "cats and dogs".to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs.", string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.
  ## 翻译：有一点很重要，symbol 对象不是“不可变的字符串”
  ## 尽管，它们确实不可变
  ## 字符串上有趣的操作，symbols 都没有 

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    assert_raise(NoMethodError) do
    ## 注意思考：为什么是 NoMethodError（没有这个方法）呢，为什么起这个名字？
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?
  ## 答：跟前面 about_string 里一个思考题，差不多
  ## 零碎的 Symbol 对象，占内存
end
