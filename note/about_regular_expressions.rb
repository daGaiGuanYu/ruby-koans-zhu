# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutRegularExpressions < Neo::Koan
  def test_a_pattern_is_a_regular_expression
    assert_equal Regexp, /pattern/.class
  end

  def test_a_regexp_can_search_a_string_for_matching_content
    assert_equal 'match', "some matching content"[/match/]
  end

  def test_a_failed_match_returns_nil
    assert_equal nil, "some matching content"[/missing/]
  end

  # ------------------------------------------------------------------

  def test_question_mark_means_optional
    assert_equal 'ab', "abbcccddddeeeee"[/ab?/]
    ## 上面的例子中，其实 'a' 也符合规则，但结果为什么不是 'a' 而是 'ab'?
    ## 因为，ruby 会找尽量长的匹配的内容
    ## 但是，结果不一定是“最长的”
    ## 因为 ruby 会在“第一个匹配”（从左往右）的子字符串的基础上，“尽量得长”
    assert_equal 'a', "abbcccddddeeeee"[/az?/]
  end

  def test_plus_means_one_or_more
    assert_equal 'bccc', "abbcccddddeeeee"[/bc+/]
  end

  def test_asterisk_means_zero_or_more
    assert_equal 'abb', "abbcccddddeeeee"[/ab*/]
    assert_equal 'a', "abbcccddddeeeee"[/az*/]
    assert_equal '', "abbcccddddeeeee"[/z*/]
    ## 最后一例，不是没匹配到任何内容
    ## z* 表示“有或者没有 z 字符”，
    ## 显然，例子中的字符串是满足这个条件的
    ## 所以返回的是 ''，而不是 nil（对比 test_a_failed_match_returns_nil）

    # THINK ABOUT IT:
    #
    # When would * fail to match?
    ## 答：好像是永远不会，，，

  end

  # THINK ABOUT IT:
  #
  # We say that the repetition operators above are "greedy."
  #
  # Why?
  ## 答：test_question_mark_means_optional 中 “第一个”、“尽量长”

  # ------------------------------------------------------------------

  def test_the_left_most_match_wins
    assert_equal 'a', "abbccc az"[/az*/] ## “第一个”
  end

  # ------------------------------------------------------------------

  def test_character_classes_give_options_for_a_character
    animals = ["cat", "bat", "rat", "zat"]
    assert_equal ['cat', 'bat', 'rat'], animals.select { |a| a[/[cbr]at/] }
  end

  def test_slash_d_is_a_shortcut_for_a_digit_character_class
    assert_equal '42', "the number is 42"[/[0123456789]+/]
    assert_equal '42', "the number is 42"[/\d+/]
  end

  def test_character_classes_can_include_ranges
    assert_equal '42', "the number is 42"[/[0-9]+/]
  end

  def test_slash_s_is_a_shortcut_for_a_whitespace_character_class
    assert_equal " \t\n", "space: \t\n"[/\s+/]
  end

  def test_slash_w_is_a_shortcut_for_a_word_character_class
    # NOTE:  This is more like how a programmer might define a word.
    assert_equal 'variable_1', "variable_1 = 42"[/[a-zA-Z0-9_]+/]
    assert_equal 'variable_1', "variable_1 = 42"[/\w+/]
  end

  def test_period_is_a_shortcut_for_any_non_newline_character
    assert_equal "abc", "abc\n123"[/a.+/]
  end

  def test_a_character_class_can_be_negated
    assert_equal 'the number is ', "the number is 42"[/[^0-9]+/]
  end

  def test_shortcut_character_classes_are_negated_with_capitals
    assert_equal 'the number is ', "the number is 42"[/\D+/]
    assert_equal 'space:', "space: \t\n"[/\S+/]
    # ... a programmer would most likely do
    assert_equal ' = ', "variable_1 = 42"[/[^a-zA-Z0-9_]+/]
    assert_equal ' = ', "variable_1 = 42"[/\W+/]
  end

  # ------------------------------------------------------------------

  def test_slash_a_anchors_to_the_start_of_the_string
    assert_equal 'start', "start end"[/\Astart/]
    assert_equal nil, "start end"[/\Aend/]
  end

  def test_slash_z_anchors_to_the_end_of_the_string
    assert_equal 'end', "start end"[/end\z/]
    assert_equal nil, "start end"[/start\z/]
  end

  def test_caret_anchors_to_the_start_of_lines
    assert_equal '2', "num 42\n2 lines"[/^\d+/]
  end

  def test_dollar_sign_anchors_to_the_end_of_lines
    assert_equal '42', "2 lines\nnum 42"[/\d+$/]
  end

  def test_slash_b_anchors_to_a_word_boundary
    assert_equal 'vines', "bovine vines"[/\bvine./]
  end

  # ------------------------------------------------------------------

  def test_parentheses_group_contents
    assert_equal 'hahaha', "ahahaha"[/(ha)+/]
  end

  # ------------------------------------------------------------------

  def test_parentheses_also_capture_matched_content_by_number
    assert_equal 'Gray', "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal 'James', "Gray, James"[/(\w+), (\w+)/, 2]
  end

  def test_variables_can_also_be_used_to_access_captures
    assert_equal 'Gray, James', "Name:  Gray, James"[/(\w+), (\w+)/]
    assert_equal 'Gray', $1
    assert_equal 'James', $2
  end

  # ------------------------------------------------------------------

  def test_a_vertical_pipe_means_or
    grays = /(James|Dana|Summer) Gray/
    assert_equal 'James Gray', "James Gray"[grays]
    assert_equal 'Summer', "Summer Gray"[grays, 1]
    assert_equal nil, "Jim Gray"[grays, 1]
  end

  # THINK ABOUT IT:
  #
  # Explain the difference between a character class ([...]) and alternation (|).
  ## 答：感觉有点风马牛不相及
  # ------------------------------------------------------------------

  def test_scan_is_like_find_all
    assert_equal ['one', 'two', 'three'], "one two-three".scan(/\w+/)
  end

  def test_sub_is_like_find_and_replace
    assert_equal 'one t-three', "one two-three".sub(/(t\w*)/) { $1[0, 1] }
    ## $1[0, 1] 表示“上一次命中（匹配）到的第一个子串”
  end

  def test_gsub_is_like_find_and_replace_all
    assert_equal 'one t-t', "one two-three".gsub(/(t\w*)/) { $1[0, 1] }
  end
end
