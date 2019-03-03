require "./field"
require "./board"
require "./pieces"

def get_piece_positions(piece)
  positions = Set.new
  pos = piece.flush_left.flush_top
  positions << pos
  pos = pos.flip_and_flush
  positions << pos

end

PIECES.each do |piece|
  puts piece
end
