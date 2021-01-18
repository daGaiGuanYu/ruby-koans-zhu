# Triangle Project Code.
## 三角形项目代码。

# Triangle analyzes the lengths of the sides of a triangle
## 此项目分析一个三角形的边的长度
# (represented by a, b and c) and returns the type of triangle.
## （使用 a，b，c 代表各边）返回三角形的类型。
#
# It returns:
## （返回的东西有：）
#   :equilateral  if all sides are equal
##                所有的边都相等
#   :isosceles    if exactly 2 sides are equal
##                有两边相等
#   :scalene      if no sides are equal
##                没有相等的边
#
# The tests for this method can be found in
## 这个方法的测试，可以在以下文件中找到
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  ## 这个方法，在两个题目中用到，第一题，值判断三角形的类型
  ## 第二题要在判断之前，检查这个三角形是否是“合法的三角形”，即“每条边的边长都大于零、每两条边都大于第三边”
  ## 做第一题时，先忽略前两行代码
  a, b, c = [a, b, c].sort ## 排序过后，a 最小，c 最大
  raise TriangleError if (a <= 0 || a + b <= c)
  # WRITE THIS CODE
  if a == b && b == c
    :equilateral
  elsif a == b || b == c || a == c
    :isosceles
  else
    :scalene
  end
end

## 在 ruby china 上看到这样一个解答（我做了一点点修改，原文链接：https://ruby-china.org/topics/15476）
# def triangle a, b, c
#   [:equilateral,:isosceles,:scalene][[a,b,c].uniq.size - 1]
# end
## 这种写法，虽然没什么意义，但很有意思
## 代码可读性太低（感觉运行效率也低一点）
## 但，用一行解决，还是很值得玩味
## 有人说这是“优雅”，但我更愿意称之为“花里胡哨”

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
