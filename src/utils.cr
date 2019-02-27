struct Field
  def initialize(@field = 0_u64)
  end

  LEFT_COLUMN  = 0b_10000000_10000000_10000000_10000000_10000000_10000000_10000000_10000000
  RIGHT_COLUMN = 0b_00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001
  TOP_ROW      = 0b_11111111_00000000_00000000_00000000_00000000_00000000_00000000_00000000
  BOTTOM_ROW   = 0b_00000000_00000000_00000000_00000000_00000000_00000000_00000000_11111111

  def can_shift_left
    @field & LEFT_COLUMN == 0
  end

  def can_shift_right
    @field & RIGHT_COLUMN == 0
  end

  def can_shift_up
    @field & TOP_ROW == 0
  end

  def can_shift_down
    @field & BOTTOM_ROW == 0
  end

  def shift_right
  	@field >>= 1 if can_shift_right
    self
  end

  def shift_down
  	@field >>= 8 if can_shift_down
    self
  end

  def flush_left
  	while can_shift_left
  		@field <<= 1
  	end
    self
  end

  def flush_top
  	while can_shift_up
  		@field <<= 8
  	end
    self
  end

  K1 = 0x_aa00_aa00_aa00_aa00
  K2 = 0x_cccc_0000_cccc_0000
  K3 = 0x_f0f0_f0f0_0f0f_0f0f

  def flip_diagonal
  	tt = @field ^ (@field << 36)
  	@field = @field ^ (K3 & (tt ^ (@field >> 36)))
  	tt = K2 & (@field ^ (@field << 18))
  	@field = @field ^ (tt ^ (tt >> 18))
  	tt = K1 & (@field ^ (@field <<  9))
  	@field = @field ^ (tt ^ (tt >>  9))
  	self
  end

  K4 = 0x_00ff_00ff_00ff_00ff
  K5 = 0x_0000_ffff_0000_ffff

  def flip_horizontal
  	@field = ((@field >>  8) & K4) | ((@field & K4) <<  8)
  	@field = ((@field >> 16) & K5) | ((@field & K5) << 16)
  	@field = (@field >> 32) | (@field << 32)
  	self
  end

  def rotate
  	flip_diagonal
    flip_horizontal
  end

  def flip_and_flush
  	flip_horizontal
    flush_top
    flush_left
  end

  def rotate_and_flush
  	rotate
    flush_top
    flush_left
  end

  def to_s(io)
    io << '\n'
    7.downto 0 do |i|
      7.downto 0 do |j|
        c = @field.bit(i * 8 + j) == 1 ? 'X' : '·'
        io << c << ' '
      end
      io << '\n'
    end
  end
end
