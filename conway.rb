class Board
  def initialize size, alives=[]
    @size = size
    @board = (0..size-1).map do |x|
               (0..size-1).map do |y|
                 Cell.new(x, y, alives.include?([x, y]) ? :alive : :dead, self)
               end
             end
  end

  def [](x, y)
    row = @board[x]
    row and row[y]
  end

  def neighbor_positions(x, y)
    [x -1, x, x + 1].map do |x_prime|
      [y - 1, y, y + 1].map do |y_prime|
        next if x == x_prime and y == y_prime
        [x_prime, y_prime]
      end
    end.flatten(1).compact
  end

  def neighbors(x, y)
    neighbor_positions(x, y).map {|(x, y)| self[x, y] }.compact
  end

  def display
    @board.each do |row|
      row.each do |cell|
        print cell.alive? ? "* " : ". "
      end
      puts
    end
    puts

    self
  end

  def run!
    @board = next_board
  end

  def next_board
    @board.map do |row|
      row.map do |cell|
        cell.run
      end
    end
  end

  def simulate(rounds)
    rounds.times do
      run!
      display
    end
  end
end

class Cell
  attr_accessor :state
  attr_reader :x, :y

  def initialize(x, y, state, board)
    @x, @y, @state, @board = x, y, state, board
  end

  def to_s
    "(#{x}, #{y}):#{state}"
  end

  def alive?
    @state == :alive
  end

  def neighbors
    @board.neighbors(x, y)
  end

  def live_neighbors
    neighbors.select(&:alive?).size
  end

  def next_state
    if (state == :dead)
      live_neighbors == 3 ? :alive : :dead
    else
      [2,3].include?(live_neighbors) ? :alive : :dead
    end
  end

  def run
    self.class.new @x, @y, next_state, @board
  end
end

board = Board.new(6, [[1, 1], [1, 2], [2, 1], [3, 4], [4, 3], [4, 4]])
board.display
board.simulate(5)
