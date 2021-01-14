require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutStrings < Neo::Koan
  def test_double_quoted_strings_are_strings
    string = "Hello, World"
    assert_equal true, string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    assert_equal true, string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    ## 当一个字符串里有双引号时，外面用单引号方便一点
    string = 'He said, "Go Away."'
    ## 很多题都没有固定的答案，我这里这么写，是想展示“如果一个字符串里有双引号，那么外面也用双引号会比较麻烦”
    assert_equal "He said, \"Go Away.\"", string 
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"
    assert_equal 'Don\'t', string
  end

  def test_use_backslash_for_those_hard_cases
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'
    assert_equal true, a == b
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a = %(flexible quotes can handle both ' and " characters)
    b = %!flexible quotes can handle both ' and " characters!
    c = %{flexible quotes can handle both ' and " characters}
    ## 不仅小括号、感叹号、大括号有这种功能，很多符号都可以
    assert_equal true, a == b
    assert_equal true, a == c
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %{
It was the best of times,
It was the worst of times.
}
    assert_equal 54, long_string.length ## 一个一个数吧，，，，注意，第一个和最后一个字符都是换行符
    assert_equal 3, long_string.lines.count ## 这个，就不要纠结是 三 还是 四 了，毕竟“第四行”没内容，不算一行
    assert_equal "\n", long_string[0,1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    ## 和上例不同的是，这种写法，开头的 EOS 要单独占一行
    ## 要不，解析器怎么知道这个 EOS 是字符串开始的标识，还是字符串的一部分
    ## 而结尾的 EOS 不需要单独占一行
    ## 因为，开头有 EOS，解析器已经知道字符串的结尾有 EOS，并且它是字符串结束的标识，不是字符串的一部分
    ## 所以，第一个字符不是换行符，而是字母 I，最后一个字符不是句号，而是换行符
    assert_equal 53, long_string.length ## 比上例，少一个“开头的换行符”
    assert_equal 2, long_string.lines.count ## 也就少一行
    assert_equal "I", long_string[0,1]
  end

  def test_plus_will_concatenate_two_strings
    string = "Hello, " + "World"
    assert_equal "Hello, World", string ## 如果你在这里停留了，我怀疑你少打一个空格
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = "Hello, "
    there = "World"
    string = hi + there
    assert_equal "Hello, ", hi
    assert_equal 'World', there
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = "Hello, "
    there = "World"
    hi += there
    assert_equal 'Hello, World', hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    ## 回想一下“你家共用一个房子的例子”
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi += there
    assert_equal "Hello, ", original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = "Hello, "
    there = "World"
    hi << there
    assert_equal "Hello, World", hi
    assert_equal "World", there
  end

  def test_the_shovel_operator_modifies_the_original_string
    ## 回想一下“你家共用一个房子的例子”
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there
    assert_equal "Hello, World", original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
    ## 答：每使用一次 +=，都会产生一个新的字符串，于此同时，旧的字符串也不会消失（ruby 会认为你还会用到它，所以不清除）
    ## 如果构建步骤比较复杂，就会产生很多零碎的字符串，没什么用，只会占用内存
    ## 但是使用 <<，会在原字符串的基础上追加字符，内存占用少

    ## 当然，构建字符串也不一定都要用 <<，还是要具体问题具体分析
    ## tend to 是“往往会，很可能会”不是“一定会”
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    assert_equal 1, string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    assert_equal 2, string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\'' ## 单引号的字符串只对“反斜线”、“单引号”进行转义
    assert_equal 2, string.size
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    string = "The value is #{value}"
    assert_equal "The value is 123", string
  end

  def test_single_quoted_strings_do_not_interpolate
    value = 123
    string = 'The value is #{value}'
    assert_equal "The value is \#{value}", string
  end

  def test_any_ruby_expression_may_be_interpolated
    string = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal "The square root of 5 is 2.23606797749979", string ## 使用 irb 计算 Math.sqrt(5) 的值
  end

  def test_you_can_get_a_substring_from_a_string
    string = "Bacon, lettuce and tomato"
    ## 好像跟数组差不多，好像，，，
    assert_equal "let", string[7,3]
    assert_equal 'let', string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal 'a', string[1]

    # Surprised?
  end

  in_ruby_version("1.8") do ## 如果你的 ruby 是 1.8 版本的，需要做这题，否则不需要
    ## 如果你真的是 1.8，建议赶紧装 2.x
    def test_in_older_ruby_single_characters_are_represented_by_integers
      assert_equal __, ?a
      assert_equal __, ?a == 97

      assert_equal __, ?b == (?a + 1)
    end
  end

  in_ruby_version("1.9", "2") do ## 如果你的 ruby 是 1.9 或 2.x 版本的，需要做这题，否则不需要
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      assert_equal 'a', ?a
      assert_equal false, ?a == 97 ## 在 C 语言中，此表达式是 true
    end
  end

  def test_strings_can_be_split
    string = "Sausage Egg Cheese"
    words = string.split ## 默认情况下，会以空格分隔字符串
    assert_equal ['Sausage', 'Egg', 'Cheese'], words
  end

  def test_strings_can_be_split_with_different_patterns
    string = "the:rain:in:spain"
    words = string.split(/:/)
    assert_equal ['the', 'rain', 'in', 'spain'], words

    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  We will become
    # enlightened about them soon.
  end

  def test_strings_can_be_joined
    words = ["Now", "is", "the", "time"]
    assert_equal 'Now is the time', words.join(" ")
  end

  def test_strings_are_unique_objects
    a = "a string"
    b = "a string"

    assert_equal true, a           == b
    assert_equal false, a.object_id == b.object_id
    ## 双等号的结果是相等，是因为 ruby 做了特殊处理
    ## 实际上，他们俩并不是一个对象
  end
end
