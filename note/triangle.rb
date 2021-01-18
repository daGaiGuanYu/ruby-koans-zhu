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
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  # WRITE THIS CODE
  if a == b && b == c
    :equilateral
  elsif a == b || b == c || a == c
    :isosceles
  else
    :scalene
  end
  ## 未考虑“不合法的三角形”
  ## 没有绝对的完美，只有合适
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
