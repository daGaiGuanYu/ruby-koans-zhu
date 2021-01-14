require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutHashes < Neo::Koan
  def test_creating_hashes
    empty_hash = Hash.new
    assert_equal Hash, empty_hash.class
    assert_equal({}, empty_hash)
    assert_equal 0, empty_hash.size
  end

  def test_hash_literals
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.size
  end

  def test_accessing_hashes
    hash = { :one => "uno", :two => "dos" }
    assert_equal 'uno', hash[:one]
    assert_equal 'dos', hash[:two]
    assert_equal nil, hash[:doesnt_exist]
  end

  def test_accessing_hashes_with_fetch
    hash = { :one => "uno" }
    assert_equal 'uno', hash.fetch(:one)
    assert_raise(KeyError) do
      hash.fetch(:doesnt_exist)
    end

    # THINK ABOUT IT:
    #
    # Why might you want to use #fetch instead of #[] when accessing hash keys?
    ## 答：如果你希望“取不存在的 key 时报错”，则应该使用 fetch
    ## 为什么我希望报错？难道不应该减少报错吗？
    ## 报错是对错误进行提示，如果程序错了，不报错，就有点掩耳盗铃了
  end

  def test_changing_hashes
    hash = { :one => "uno", :two => "dos" }
    hash[:one] = "eins"

    expected = { :one => 'eins', :two => "dos" }
    assert_equal expected, hash

    # Bonus Question: Why was "expected" broken out into a variable
    # rather than used as a literal?
    ## 答：字面量，会被误以为是个“块函数”
  end

  def test_hash_is_unordered
    hash1 = { :one => "uno", :two => "dos" }
    hash2 = { :two => "dos", :one => "uno" }

    assert_equal true, hash1 == hash2
    ## 这个题设计得不太好，因为按说，他不要求读者了解 assert 的内部实现
    ## 这里只需要知道 hash 是无序的就行了
  end

  def test_hash_keys
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.keys.size
    assert_equal true, hash.keys.include?(:one)
    assert_equal true, hash.keys.include?(:two)
    assert_equal Array, hash.keys.class
  end

  def test_hash_values
    hash = { :one => "uno", :two => "dos" }
    assert_equal 2, hash.values.size
    assert_equal true, hash.values.include?("uno")
    assert_equal true, hash.values.include?("dos")
    assert_equal Array, hash.values.class
  end

  def test_combining_hashes
    hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
    new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

    assert_equal true, hash != new_hash

    expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 } ## 后面的值，当然会覆盖前面的值
    assert_equal true, expected == new_hash
  end

  def test_default_value
    hash1 = Hash.new
    hash1[:one] = 1

    assert_equal 1, hash1[:one]
    assert_equal nil, hash1[:two]

    hash2 = Hash.new("dos") ## new 后面是所有 key 的默认值
    hash2[:one] = 1 ## 但单独设置的值的优先级，肯定高于默认值的

    assert_equal 1, hash2[:one]
    assert_equal 'dos', hash2[:two]
  end

  def test_default_value_is_the_same_object
    hash = Hash.new([]) ## new 后面，是默认值，是共享的，也就是所有的 key 都对应一个 []

    hash[:one] << "uno" ## 这句，不是对 hash[:one] 的值进行改变，而是向 hash[:one] 所对应的那个数组里添加值
    ## 有一个通俗的例子：你们家有你、你老婆、你儿子这几个人，住在一个房子里，这个房子是你们的家
    ## 你、你老婆、你儿子就相当于 hash 的 key，这个房子就是默认值
    ## 当“小明走进你儿子的家”时，“你老婆的家”里是不是也多了一个人？但是你们家还是你们家，没变
    ## 只有当你儿子长大了，有了自己的新家，比如 hash[:儿子] = 新家
    ## 这样，hash[:儿子]，才算“变了”
    hash[:two] << "dos" ## 如果你学过 c 语言，那么可以理解为“指针所指的方向未变，变的是被指的那块区域”

    assert_equal ['uno', 'dos'], hash[:one]
    assert_equal ['uno', 'dos'], hash[:two]
    assert_equal ['uno', 'dos'], hash[:three] ## 这个 three 就像你未出生的女儿，她也和你们共用一个家

    assert_equal true, hash[:one].object_id == hash[:two].object_id
  end

  def test_default_value_with_block
    ## 如果你想为每一个 key，指定单独的数组，可以像下面这样
    hash = Hash.new {|hash, key| hash[key] = [] }

    hash[:one] << "uno"
    hash[:two] << "dos"

    assert_equal ['uno'], hash[:one]
    assert_equal ['dos'], hash[:two]
    assert_equal [], hash[:three]
  end
end
