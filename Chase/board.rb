require_relative 'piece'



class Board
    attr_reader :board

    def initialize(fill_board = true)
        # @board = Array.new(8) {Array.new(8, nil)}
        @sentinel = NullPiece.instance
        # @null_piece = NullPiece.new
        start_pieces
        
    end

    # def start_pieces
    #     (0...@board.size).each do |i|
    #         @board[0][i] = Piece.new
    #         @board[1][i] = Piece.new
    #         @board[6][i] = Piece.new
    #         @board[7][i] = Piece.new
    #     end
    # end
    

    def [](pos)
        raise 'invalid pos' unless valid_pos?(pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos,val)
        raise 'invalid pos' unless valid_pos?(pos)
        row, col = pos
        @board[row][col] =val
    end

    # def move_piece(start_pos,end_pos)
        
    #     begin
    #         @board[start_pos] , @board[end_pos] = @board[end_pos] , @board[start_pos]
    #     rescue => exception
    #         puts "no piece at starting position or piece cannot move to end position"
    #     end
    # end
      def move_piece(turn_color, start_pos, end_pos)
    raise 'start position is empty' if empty?(start_pos)

    piece = self[start_pos]
    if piece.color != turn_color
      raise 'You must move your own piece'
    elsif !piece.moves.include?(end_pos)
      raise 'Piece does not move like that'
    elsif !piece.valid_moves.include?(end_pos)
      raise 'You cannot move into check'
    end

    move_piece!(start_pos, end_pos)
  end

  # move without performing checks
  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

    self[end_pos] = piece
    self[start_pos] = sentinel
    piece.pos = end_pos

    nil
  end

    private

  attr_reader :sentinel

  def fill_back_row(color)
    back_pieces = [
      Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook
    ]

    i = color == :white ? 7 : 0
    back_pieces.each_with_index do |piece_class, j|
      piece_class.new(color, self, [i, j])
    end
  end

  def fill_pawns_row(color)
    i = color == :white ? 6 : 1
    8.times { |j| Pawn.new(color, self, [i, j]) }
  end

  def find_king(color)
    king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
    king_pos || (raise 'king not found?')
  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, sentinel) }
    return unless fill_board
    %i(white black).each do |color|
      fill_back_row(color)
      fill_pawns_row(color)
    end
  end
end



#knight MOVES = [[-1,-2],[-2,-1],[-2,1],[-1,2],[1,-2],[2,-1],[2,1],[1,2]]
# bishop diagonally
# rook up/down
# queen up/down + diagonally
# king move anywhere 1 spot 
# pawn 

# 1 2 3 4 5 6 7 8 
# 9 1 1 2 3 4 5 6




# 1 2 3 4 5 6 7 8 
# 9 1 1 2 3 4 5 6 