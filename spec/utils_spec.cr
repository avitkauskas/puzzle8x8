require "./spec_helper"
require "../src/utils"

describe Field do
  describe "#shift_right" do
    it "shifts the field one column to the right" do
      original = Factory.original
      shifted_right = Factory.shifted_right
      original.shift_right.field.should eq shifted_right.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.shift_right
      original.field.should eq copy.field
    end
  end

  describe "#shift_down" do
    it "shifts the field one column down" do
      original = Factory.original
      shifted_down = Factory.shifted_down
      original.shift_down.field.should eq shifted_down.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.shift_down
      original.field.should eq copy.field
    end
  end

  describe "#flush_left" do
    it "flushes the field all the way to the left" do
      original = Factory.original
      flushed_left = Factory.flushed_left
      original.flush_left.field.should eq flushed_left.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.flush_left
      original.field.should eq copy.field
    end
  end

  describe "#flush_top" do
    it "flushes the field all the way to the top" do
      original = Factory.original
      flushed_top = Factory.flushed_top
      original.flush_top.field.should eq flushed_top.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.flush_top
      original.field.should eq copy.field
    end
  end

  describe "#flip_diagonal" do
    it "flips the field by diagonal" do
      original = Factory.original
      flipped_diagonal = Factory.flipped_diagonal
      original.flip_diagonal.field.should eq flipped_diagonal.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.flip_diagonal
      original.field.should eq copy.field
    end
  end

  describe "#flip_horizontal" do
    it "flips the field horizontaly" do
      original = Factory.original
      flipped_horizontal = Factory.flipped_horizontal
      original.flip_horizontal.field.should eq flipped_horizontal.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.flip_horizontal
      original.field.should eq copy.field
    end
  end

  describe "#rotate" do
    it "rotates field 90 degrees clockwise" do
      original = Factory.original
      rotated = Factory.rotated
      original.rotate.field.should eq rotated.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.rotate
      original.field.should eq copy.field
    end
  end

  describe "#flip_and_flush" do
    it "flips field and flushes it top-left" do
      original = Factory.original
      flipped_flushed = Factory.flipped_flushed
      original.flip_and_flush.field.should eq flipped_flushed.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.flip_and_flush
      original.field.should eq copy.field
    end
  end

  describe "#rotate_and_flush" do
    it "rotates field and flushes it top-left" do
      original = Factory.original
      rotated_flushed = Factory.rotated_flushed
      original.rotate_and_flush.field.should eq rotated_flushed.field
    end

    it "should not modify the original" do
      original = Factory.original
      copy = Factory.original
      original.rotate_and_flush
      original.field.should eq copy.field
    end
  end

  describe "#put" do
    it "puts one field on the other" do
      original = Factory.original
      other = Factory.other
      combined = Factory.combined
      original.put(other).field.should eq combined.field
    end

    it "should not put if it does not fit" do
      original = Factory.original
      other = Factory.shifted_right
      original.put(other).field.should eq original.field
    end

    it "should not modify the original" do
      original = Factory.original
      other = Factory.other
      copy = Factory.original
      original.put other
      original.field.should eq copy.field
    end
  end

  describe "#remove" do
    it "removes one field from the other" do
      original = Factory.original
      other = Factory.other
      combined = Factory.combined
      combined.remove(other).field.should eq original.field
    end

    it "should not do anything if field to remove was not put" do
      original = Factory.original
      other = Factory.shifted_right
      original.remove(other).field.should eq original.field
    end

    it "should not modify the original" do
      combined = Factory.combined
      other = Factory.other
      copy = Factory.combined
      combined.remove other
      combined.field.should eq copy.field
    end
  end
end

module Factory
  def self.original
    Field.new(<<-FIELD)
    00000000
    00001110
    00000010
    FIELD
  end

  def self.other
    Field.new(<<-FIELD)
    00010000
    00010000
    00001100
    FIELD
  end

  def self.combined
    Field.new(<<-FIELD)
    00010000
    00011110
    00001110
    FIELD
  end

  def self.shifted_right
    Field.new(<<-FIELD)
    00000000
    00000111
    00000001
    FIELD
  end

  def self.shifted_down
    Field.new(<<-FIELD)
    00000000
    00000000
    00001110
    00000010
    FIELD
  end

  def self.flushed_left
    Field.new(<<-FIELD)
    00000000
    11100000
    00100000
    FIELD
  end

  def self.flushed_top
    Field.new(<<-FIELD)
    00001110
    00000010
    FIELD
  end

  def self.flipped_diagonal
    Field.new(<<-FIELD)
    00000000
    00000110
    00000010
    00000010
    FIELD
  end

  def self.flipped_horizontal
    Field.new(<<-FIELD)
    00000000
    00000000
    00000000
    00000000
    00000000
    00000010
    00001110
    FIELD
  end

  def self.rotated
    Field.new(<<-FIELD)
    00000000
    00000000
    00000000
    00000000
    00000010
    00000010
    00000110
    FIELD
  end

  def self.flipped_flushed
    Field.new(<<-FIELD)
    00100000
    11100000
    FIELD
  end

  def self.rotated_flushed
    Field.new(<<-FIELD)
    01000000
    01000000
    11000000
    FIELD
  end
end
