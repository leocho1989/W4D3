

require_relative 'board.rb'
require 'colorize'

class Piece

    attr_reader :board, :color
    attr_accessor :pos

    def initialize
        @board = board
        @color = color
        @pos = pos

        raise 'invalid color' unless %i(white black).include?(color)
        raise 'invalid pos' unless board.valid_pos?(pos)
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        false
    end

    def valid_moves?
        moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    def pos=(val)
    end

    def move_into_check?(end_pos)
        test_board = board.dup
        test_board.move_piece!(pos, end_pos)
        test_board.in_check?(color)
    end


end