require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutObjects < Neo::Koan
  def test_everything_is_an_object
    assert_equal true, 1.is_a?(Object)
    assert_equal true, 1.5.is_a?(Object) ## 小数(1.5)
    assert_equal true, "string".is_a?(Object)
    assert_equal true, nil.is_a?(Object)
    assert_equal true, Object.is_a?(Object) ## 类也是“对象”
  end

  def test_objects_can_be_converted_to_strings
    assert_equal '123', 123.to_s
    assert_equal '', nil.to_s
  end

  def test_objects_can_be_inspected
    assert_equal '123', 123.inspect
    assert_equal 'nil', nil.inspect
  end

  def test_every_object_has_an_id
    obj = Object.new
    assert_equal Integer, obj.object_id.class
  end

  def test_every_object_has_different_id
    obj = Object.new
    another_obj = Object.new
    assert_equal true, obj.object_id != another_obj.object_id
  end

  def test_small_integers_have_fixed_ids
    ## 这一题，可以使用 irb 来测试，也可以输入 rake 之后，看提示
    assert_equal 1, 0.object_id
    assert_equal 3, 1.object_id
    assert_equal 5, 2.object_id
    assert_equal 201, 100.object_id
    ## 比较小的整数，有固定的 object_id

    # THINK ABOUT IT:
    # What pattern do the object IDs for small integers follow?
    ## 答：(2n + 1)
  end

  def test_clone_creates_a_different_object
    obj = Object.new
    copy = obj.clone

    assert_equal true, obj           != copy
    assert_equal true, obj.object_id != copy.object_id
  end
end
