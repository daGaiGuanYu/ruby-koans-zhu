require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutNil < Neo::Koan
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), "Unlike NULL in other languages"
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.
    begin
      nil.some_method_nil_doesnt_know_about
    rescue Exception => ex
      # What exception has been caught?
      ## 如果你没使用过其他编程语言，可以跳过这一题
      ## 其他语言中，如果对象不存在，一般会报“空指针异常”、“试图调用一个不存在的对象的方法”或者类似的错误
      ## 而 ruby 中，nil 不是不存在，而是一个特殊的对象，既然是对象，就代表“存在”，就不会出现“空指针”
      assert_equal NoMethodError, ex.class

      # What message was attached to the exception?
      # (HINT: replace __ with part of the error message.)
      assert_match(/doesnt_know/, ex.message) # 这里，随便写一些报错信息即可
    end
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal true, nil.nil?
    assert_equal '', nil.to_s
    assert_equal 'nil', nil.inspect

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
    ## 答：经过我的搜索，这两者没有太大区别，至少对于初学者来说关系不大
  end

end
