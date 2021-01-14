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
里面有“原练习题”文件夹，就是*未经任何改动*的原始的从官网下载的源码  

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

最后一行，是你的做题进度，现在当然是 0% 了  

倒数第三行：
```base
D:/workspace/ruby-koans-zhu/原练习题/about_asserts.rb:10:in `test_assert_truth'
```
是你当前要做的题：```原练习题```文件夹下的```about_assert.rb```文件的第```10```行  

祝，早日心明眼亮。