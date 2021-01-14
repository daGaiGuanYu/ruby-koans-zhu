# ruby-koans 注
[ruby koans](http://rubykoans.com/) 是一套“练习题”（[ruby 官方推荐](https://www.ruby-lang.org/zh_cn/documentation/)）  
如果你刚学了 ruby 的语法，想加深记忆，那 ruby koans 很合适  

但是，做练习题，没有参考答案，就很不舒服  
此仓库，就是一些**参考答案**，以及**个人的笔记**  

共勉

> 如果有地方不正确、不恰当，欢迎指正、感谢教训

## 开始
本仓库分三大部分：
+ readme，就是你现在正在看的这篇
+ [原练习题](https://github.com/daGaiGuanYu/ruby-koans-zhu/tree/main/%E4%B8%AA%E4%BA%BA%E7%AD%94%E6%A1%88%E3%80%81%E7%AC%94%E8%AE%B0)，由于某种原因，下载原版的练习题，可能很慢（甚至下载不了）
+ [个人的答案、及笔记](https://github.com/daGaiGuanYu/ruby-koans-zhu/tree/main/%E4%B8%AA%E4%BA%BA%E7%AD%94%E6%A1%88%E3%80%81%E7%AC%94%E8%AE%B0)

##### 第一步，准备环境
只需要安装一个 ruby 就够了  
如果你已经学习了 ruby 的基本语法，那应该是有 ruby 的环境的  
否则，你应该先学习一下 ruby 的基本语法

##### 第二步，下载练习题
你可以 clone 一下本仓库
```bash
git clone https://github.com/daGaiGuanYu/ruby-koans-zhu.git
```
里面有“原练习题”文件夹，就是**未经任何改动**的原始的从官网下载的源码  

或者你对你的网络有信心，也可以从官网下载，点[这个链接](http://rubykoans.com/)

##### 第三步，开始做题
+ 打开命令行工具
+ 切换到“练习题”所在的文件夹
+ 输入 rake，回车，你将看到：

```bash
PS D:\workspace\ruby-koans-zhu\原练习题> rake
C:/Ruby27-x64/bin/ruby.exe path_to_enlightenment.rb
AboutAsserts#test_assert_truth has damaged your karma.

The Master says:
  You have not yet reached enlightenment.

The answers you seek...
  Failed assertion.

Please meditate on the following code:
  D:/workspace/ruby-koans-zhu/原练习题/about_asserts.rb:10:in `test_assert_truth'

mountains are merely mountains
your path thus far [X_________________________________________________] 0/281 (0%)
```

最后一行，是你的做题进度  
0/281 表示总共有 281 道题，你现在已完成 0 道，也就是 0%  

倒数第三行：
```base
D:/workspace/ruby-koans-zhu/原练习题/about_asserts.rb:10:in `test_assert_truth'
```
是你当前要做的题：```原练习题```文件夹下的```about_assert.rb```文件的第```10```行  

祝，早日心明眼亮。

> 如果你也像我刚接触 ruby koans 时一样：到这里，依然一头雾水，那请务必再多花 5 到 10 分钟，把本篇读完

## 做题须知
##### 比如第一部分的第一题
```ruby
def test_assert_truth
  assert false
end
```
第一部分，其实是跟你说**如何做题**  
你要做的，是 koans 让你做的那一行  
也就是输入 rake 之后，命令行里提示的“某文件夹下的某文件的第某行”  
其他的，跟练习内容，无关  
如果你感兴趣，可以做完整个练习后，再细细品味

**第一题**，只需要把第十行的 false 改为 true 就行了  
所有的练习题，都是**给 assert 一个 true**  
现在输入 rake，你会看到：
```bash
PS D:\workspace\ruby-koans-zhu\原练习题> rake
C:/Ruby27-x64/bin/ruby.exe path_to_enlightenment.rb
AboutAsserts#test_assert_truth has expanded your awareness.
AboutAsserts#test_assert_with_message has damaged your karma.

The Master says:
  You have not yet reached enlightenment.
  You are progressing. Excellent. 1 completed.

The answers you seek...
  This should be true -- Please fix this

Please meditate on the following code:
  D:/workspace/ruby-koans-zhu/原练习题/about_asserts.rb:16:in `test_assert_with_message'

learn the rules so you know how to break them properly
your path thus far [.X________________________________________________] 1/281 (0%)
```
可以看到，你现在要做的题，已经是```原练习题/about_asserts.rb```里的第 16 行了  
0/281 也变成了 1/281（不到 1%，四舍五入为 0%）

**第二题**，依然是把 false 改为 true  
后面的```"This should be true -- Please fix this"```只不过是**未完成题时的错误提示**  

**第三题**
```ruby
def test_assert_equality
  expected_value = __
  actual_value = 1 + 1

  assert expected_value == actual_value
end
```
依然有个 assert 语句，后面是一个表达式，我们的任务就是让这个表达式变成 true  
只需要把```expected_value = __```中的**双下划线**改成 ```2``` 就行了  
后面几乎所有的题目，都是**用适当的内容替换双下划线**  

**第四题 和 第五题**，出现了 assert_equal 语句  
表示**后面的参数，是“相等的”**，我想你应该知道怎么做了  

做完第四、五题之后，再输入 rake，你会看到：
```bash
PS D:\workspace\ruby-koans-zhu\原练习题> rake
C:/Ruby27-x64/bin/ruby.exe path_to_enlightenment.rb
AboutAsserts#test_assert_equality has expanded your awareness.
AboutAsserts#test_a_better_way_of_asserting_equality has expanded your awareness.
AboutAsserts#test_fill_in_values has expanded your awareness.
AboutNil#test_nil_is_an_object has damaged your karma.

The Master says:
  You have not yet reached enlightenment.
  You are progressing. Excellent. 5 completed.

The answers you seek...
  Unlike NULL in other languages

Please meditate on the following code:
  D:/workspace/ruby-koans-zhu/原练习题/about_nil.rb:5:in `test_nil_is_an_object'

sleep is the best meditation
your path thus far [.X________________________________________________] 5/281 (1%)
```
倒数第一行：你已经做了 5 道题了，进度是 1%  
倒数第三行：你现在要做的是```原练习题/about_nil.rb```的第 5 行  

##### 参考答案
本仓库的```个人答案、笔记```文件夹下，是[个人的答案和笔记](https://github.com/daGaiGuanYu/ruby-koans-zhu/tree/main/%E4%B8%AA%E4%BA%BA%E7%AD%94%E6%A1%88%E3%80%81%E7%AC%94%E8%AE%B0)  
有的题目，有些不解、启发，都会记录下来（在**中文注释**里），如有不对的地方，欢迎指正