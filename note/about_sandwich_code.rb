require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSandwichCode < Neo::Koan

  def count_lines(file_name)
    file = open(file_name)
    count = 0
    while file.gets
      count += 1
    end
    count
  ensure
    file.close if file
  end

  def test_counting_lines
    assert_equal 4, count_lines("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line(file_name)
    file = open(file_name)
    while line = file.gets
      return line if line.match(/e/)
    end
  ensure
    file.close if file
  end

  def test_finding_lines
    assert_equal "test\n", find_line("example_file.txt")
  end

  # ------------------------------------------------------------------
  # THINK ABOUT IT:
  #
  # The count_lines and find_line are similar, and yet different.
  # They both follow the pattern of "sandwich code".
  #
  # Sandwich code is code that comes in three parts: (1) the top slice
  # of bread, (2) the meat, and (3) the bottom slice of bread.  The
  # bread part of the sandwich almost always goes together, but
  # the meat part changes all the time.
  #
  # Because the changing part of the sandwich code is in the middle,
  # abstracting the top and bottom bread slices to a library can be
  # difficult in many languages.
  #
  # (Aside for C++ programmers: The idiom of capturing allocated
  # pointers in a smart pointer constructor is an attempt to deal with
  # the problem of sandwich code for resource allocation.)
  #
  # Consider the following code:
  #

  ## 注者按：举个例子，你的生活是一个程序，你的生活中，有很多事要做
  ## 比如去超市，今天，你要去买一些生活用品，牙刷、毛巾、肥皂
  ## 你可能会写这样一个方法：
  ## 出门、等公交、上公交、找位子坐下（如果有位子）、到站下车、进超市、买牙刷、买毛巾、买肥皂、离开超市、等公交、上公交、找位子坐下（如果有位子、到站下车、进家
  ## 第二天，你要去买一些零食，辣条、快乐水、薯片
  ## 你可能会写这样一个方法：
  ## 出门、等公交、上公交、找位子坐下（如果有位子）、到站下车、进超市、买辣条、买可乐、买薯片、离开超市、等公交、上公交、找位子坐下（如果有位子、到站下车、进家

  ## 你会发现，这两个方法，有大量的重复代码，只有买的东西不一样
  ## 这时候，对你的程序进行优化：你可以写一个“去超市”方法，这个方法接收一个数组，也就是购物清单
  ## 看起来不错！
  
  ## 但是，如果你去超市要买一些特殊的东西
  ## 比如买菜，菜要你挑好的菜，然后去称重，可能还要排队
  ## 或者现在有的超市有理发服务（比如我在南京一家“永辉”超市里就见过，好像很便宜）
  ## 那你传一个购物清单，显然就不太行了
  
  ## 如果你传入一些 flag，比如在“购物清单参数”后面，添加一个“vegetables”参数，一个“haircut”
  ## 并且在你的方法里添加，如果 vegetables 为真，则进行“挑菜、称重（如果要排队就排队）”
  ## 如果 hairecut 为真，则进行“洗头、找座位坐下、等 Tony 老师操作、跟 Tony 老师周旋办不办卡、洗头”
  ## 好像看起来也还行
  
  ## 但是如果又有一天，你想在超市里吃个饭呢？
  ## 或者，又有一天……
  ## 如果你把新的操作都用 if 语句的形式，添加到“去超市”这个方法，那么将来，这个方法会越来越大……
  ## 于是……
  def file_sandwich(file_name)
    file = open(file_name) ## 上面包
    yield(file) ## 肉
  ensure ## 下面包
    file.close if file
  end

  # Now we write:

  def count_lines2(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

  def test_counting_lines2
    assert_equal 4, count_lines2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line2(file_name)
    # Rewrite find_line using the file_sandwich library function.
    file_sandwich(file_name) do |file|
      while line = file.gets
        return line if line.match(/e/)
      end
    end
  end

  def test_finding_lines2
    assert_equal "test\n", find_line2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def count_lines3(file_name)
    open(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

  def test_open_handles_the_file_sandwich_when_given_a_block
    assert_equal 4, count_lines3("example_file.txt")
  end

end
