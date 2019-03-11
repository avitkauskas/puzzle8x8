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

  # include all rotations of both flip sides
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

def get_cell_choices(positions)
  choices = Array.new(64) { [] of Field }

  positions.each do |pos|
    cells = pos.covered_cells
    cells.each do |i|
      choices[i] << pos
    end
  end

  choices
end

def find_solutions(board, positions, solutions, unused_pieces, partial_solution)
  cell = board.lowest_uncovered_cell
  if cell
    unused_pieces.each do |piece|
      positions[piece][cell].each do |pos|
        if board.can_put? pos
          board = board.put pos
          partial_solution[piece] = pos
          unused_pieces_dup = unused_pieces.dup
          unused_pieces_dup.delete piece
          if unused_pieces_dup.size == 0 # solution
            solutions << partial_solution
            # print "solutions: #{solutions.size}\n"
          else
            find_solutions(board, positions, solutions, unused_pieces_dup, partial_solution)
          end
          board = board.remove pos
          partial_solution[piece] = Field.new
        end
      end
    end
  end
end

# [piece][cell][piece_position_0, piece_position_1, ...]
positions = Array(Array(Array(Field))).new(PIECES.size)

PIECES.each do |piece|
  pos = get_piece_positions(piece)
  positions << get_cell_choices(pos)
end

# [solution][piece_0_position, piece_1_position, ... , piece_n_position]
solutions = Array(Array(Field)).new

board = BOARD
unused_pieces = Array.new(PIECES.size) { |i| i }

find_solutions(board, positions, solutions, unused_pieces, partial_solution: Array.new(PIECES.size, Field.new))

puts solutions.size
