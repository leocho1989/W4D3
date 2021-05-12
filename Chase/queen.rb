require_relative "piece.rb"
require_relative 'slideable.rb'

class Queen < Piece
    include Slideable

    def move_dirs
        diagonal_dirs && horizontal_dirs
    end

    def symbol
        '♛'.colorize(color)
    end
end