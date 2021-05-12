require_relative 'slideable.rb'
require_relative "piece.rb"

class Rook < Piece
    include Slideable

    def move_dirs
        horizontal_dirs
    end

    def symbol
        '♜'.colorize(color)
    end


end