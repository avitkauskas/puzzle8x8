require "./field"
require "./board"
require "./pieces"

def get_piece_positions(piece)
  positions = Set(Field).new

  # include the piece itself
  pos = piece.flush_left.flush_top
  positions << pos

  # include the fipped version
  pos = pos.flip_and_flush
  positions << pos

  # include all rotations of both sides
  dup = positions.dup
  dup.each do |pos|
    3.times do
      pos = pos.rotate_and_flush
      positions << pos
    end
  end

  # include all shifts down/right of all rotations
  dup = positions.dup
  dup.each do |pos|
    p1 = pos
    loop do
      p2 = p1
      while p2.can_shift_right?
        p2 = p2.shift_right
        positions << p2
      end
      break unless p1.can_shift_down?
      p1 = p1.shift_down
      positions << p1
    end
  end

  positions
end

positions = Array(Set(Field)).new(PIECES.size)

PIECES.each do |piece|
  positions << get_piece_positions(piece)
end

positions.each do |pos|
  puts pos.size
end
