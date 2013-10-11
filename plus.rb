# -*- coding: utf-8 -*-
# 1.block 的常规用法：
# 在Ruby中，block经常用于迭代：如：
# a is an array
words = ["hello", "world", "ruby"]
words.each do |word|
  puts word
end
# 结果如下：
# hello
# world
# ruby
# ruby将数组words里的元素依次赋值给“||”中的变量word，然后执行block中的代码
# 如此循环，直到迭代玩数组中的元素

# 对于hash，用法差不多，仅有一点区别
h = {:apple => "red", :babana => "yellow"}
# 对于key是symbol的情况，ruby 1.9还支持另一种表达方式
h = {apple: "red", banana: "yellow"}
# hash使用代码块时，可以向其传递每次传递两个参数，key和相应的value
h.each do |key, value| 
  puts "the key #{key.inspect} has value string #{value}"
end
# 结果如下：
# the key :apple has value string red
# the key :banana has value string yellow

# 2,instance Method 和 class method 的区别
# 简单来讲，instance method只能被object调用，class method只能被class调用
class Sing # class name 必须大写
  def Sing.count # 定义class method count，调用方式：Sing.count
  end
  
  def self.count # 作用同上
  end
  
  def play # 定义instance method play
  end
end

the_wind_forest = Sing.new # new 同样是一个class method，预先定义在class Class中
the_wind_forest.play # 调用instance method
Sing.play # error，因为play是instance method，不能被类调用
the_wind_forest.count # error,原因与上面差不多
# 具体解释可参考：http://www.railstips.org/blog/archives/2009/05/11/class-and-instance-methods-in-ruby/

# 3.函数参数传递规则：
# 比较难说明，可参考：http://ruby.railstutorial.org/chapters/rails-flavored-ruby#sec-css_revisited
# 直接看例子就行，可以大致了解一点
