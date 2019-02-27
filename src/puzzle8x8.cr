require "./utils"

f1 = Field.new 0b_11110000_11100000_10000000_00000000_00000000_00000000_00000000_00000000

f1.rotate
puts f1
puts f1.rotate
puts f1
puts f1.flip_and_flush
puts f1.rotate_and_flush
puts f1.rotate
