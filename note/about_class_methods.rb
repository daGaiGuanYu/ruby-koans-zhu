require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutClassMethods < Neo::Koan
  class Dog
  end

  def test_objects_are_objects
    ## 任何对象都是 Object 类的实例
    fido = Dog.new
    assert_equal true, fido.is_a?(Object)
  end

  def test_classes_are_classes
    ## 任何类都是 Class 类的实例
    assert_equal true, Dog.is_a?(Class)
  end

  def test_classes_are_objects_too
    ## 把上一题中注释的定语“Class 类的”去掉，就得出：任何类都是实例
    ## 实例就是对象，再看第一题：“任何对象都是 Object 类的实例”
    ## 于是得出本题的答案
    assert_equal true, Dog.is_a?(Object)
    ## 上面只是一个逻辑推导
    ## 一个更感性的理解是：所有东西都是对象，类也是对象
    ## 就连 Object.is_a?(Object) 也成立
    ## Object 的祖先 Kernel 和 BasicObject 都满足

    ## Ruby 中，类和对象只有相对性，没有绝对性
    ## 比如 fido = Dog.new 中，fido 是对象，Dog 是类
    ## 而 Dog 和 Object 相比，Dog 是对象，Object 是类
  end

  def test_objects_have_methods
    fido = Dog.new
    assert fido.methods.size > 0
  end

  def test_classes_have_methods
    assert Dog.methods.size > 0
  end

  def test_you_can_define_methods_on_individual_objects
    fido = Dog.new
    def fido.wag
      :fidos_wag
    end
    assert_equal :fidos_wag, fido.wag
  end

  def test_other_objects_are_not_affected_by_these_singleton_methods
    fido = Dog.new
    rover = Dog.new
    def fido.wag
      :fidos_wag
    end

    assert_raise(NoMethodError) do
      rover.wag
    end
  end

  # ------------------------------------------------------------------

  class Dog2
    def wag
      :instance_level_wag
    end
  end

  def Dog2.wag
    :class_level_wag
  end

  def test_since_classes_are_objects_you_can_define_singleton_methods_on_them_too
    assert_equal :class_level_wag, Dog2.wag
  end

  def test_class_methods_are_independent_of_instance_methods
    fido = Dog2.new
    assert_equal :instance_level_wag, fido.wag
    assert_equal :class_level_wag, Dog2.wag
  end

  # ------------------------------------------------------------------

  class Dog
    attr_accessor :name
  end

  def Dog.name
    @name
  end

  def test_classes_and_instances_do_not_share_instance_variables
    fido = Dog.new
    fido.name = "Fido"
    assert_equal 'Fido', fido.name
    assert_equal nil, Dog.name
  end

  # ------------------------------------------------------------------

  class Dog
    def Dog.a_class_method
      :dogs_class_method
    end
  end

  def test_you_can_define_class_methods_inside_the_class
    assert_equal :dogs_class_method, Dog.a_class_method
  end

  # ------------------------------------------------------------------

  LastExpressionInClassStatement = class Dog
                                     21
                                   end

  def test_class_statements_return_the_value_of_their_last_expression
    assert_equal 21, LastExpressionInClassStatement
  end

  # ------------------------------------------------------------------

  SelfInsideOfClassStatement = class Dog
                                 self
                               end

  def test_self_while_inside_class_is_class_object_not_instance
    assert_equal true, Dog == SelfInsideOfClassStatement
  end

  # ------------------------------------------------------------------

  class Dog
    def self.class_method2
      :another_way_to_write_class_methods
    end
  end

  def test_you_can_use_self_instead_of_an_explicit_reference_to_dog
    assert_equal :another_way_to_write_class_methods, Dog.class_method2
  end

  # ------------------------------------------------------------------

  class Dog
    class << self
      def another_class_method
        :still_another_way
      end
    end
  end

  def test_heres_still_another_way_to_write_class_methods
    assert_equal :still_another_way, Dog.another_class_method
  end

  # THINK ABOUT IT:
  #
  # The two major ways to write class methods are:
  #   class Demo
  #     def self.method
  #     end
  #
  #     class << self
  #       def class_methods
  #       end
  #     end
  #   end
  #
  # Which do you prefer and why?
  # Are there times you might prefer one over the other?
  ## 如果你只想定义一个类方法：
  ##   使用第一种写法，至少写两行
  ##   使用第二种写法，至少写四行
  ##   第一种胜出
  ## 如果你想定义 n 个类方法(n>1)：
  ##   第一种，要写 n 次 self.xxx，类方法和实例方法有同样的缩进
  ##   第二种，可以把所有类方法都写在 class << self 里面，而且，它们拥有同样的缩进（比实例方法多一个缩进）
  ##   我们往往说，代码应“简洁”，为什么？因为“简洁”的代码，可读性更高，好看
  ##   “字母少、行数少”不一定简洁，如果多写俩字母，多点换行，能使代码更好看，则应该多写一点
  ##   所以，如果你有多个类方法，可能使用第二种写法更好一点

  # ------------------------------------------------------------------

  def test_heres_an_easy_way_to_call_class_methods_from_instance_methods
    fido = Dog.new
    assert_equal :still_another_way, fido.class.another_class_method
  end

end
