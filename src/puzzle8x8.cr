require "./utils"

empty = Field.new

f1 = Field.new 0b_11110000_11100000_10000000_00000000_00000000_00000000_00000000_00000000

f2 = Field.new(<<-FIELD)
     11110011
     11100000
     10000000
     FIELD

# empty.put f1
empty.put f2
empty.remove f1.shift_right.shift_right.shift_right

puts empty, f1

# puts f1
# puts f1.rotate
# puts f1
# puts f1.flip_and_flush
# puts f1.rotate_and_flush
# puts f1.rotate
#
# puts f1.field
