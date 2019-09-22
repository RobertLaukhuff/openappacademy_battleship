class Board
  
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) {Array.new(n, :N)}
    @size = n * n
  end

  def [](position)
    row = position[0]
    col = position[1]
    @grid[row][col]
  end

  def []=(position, value)
    row = position[0]
    col = position[1]
    @grid[row][col] = value
  end

  def num_ships
    ship_count = 0
    @grid.each do |row|
      row.each do |value|
        if value == :S
          ship_count += 1
        end
      end
    end
    ship_count
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts "you sunk my battleship!"
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    ships_to_place = @size / 4
    while ships_to_place > 0
      row = rand(0...@grid.length)
      col = rand(0...@grid.length)
      if self[[row, col]] == :N
        self[[row, col]] = :S
        ships_to_place -= 1
      end
    end
  end

  def hidden_ships_grid
    hidden_grid = Array.new(@grid.length) {Array.new(@grid.length, :N)}
    @grid.each_with_index do |row, idx1|
      row.each_with_index do |value, idx2|
        if value == :S
          hidden_grid[idx1][idx2] = :N
        else
          hidden_grid[idx1][idx2] = value
        end
      end
    end
    hidden_grid
  end

  def self.print_grid(board_grid)
    str = ""
    board_grid.each do |row|
      row.each do |value|
        str += "#{value} "
      end
      str.chomp!(" ")
      str += "\n"
    end
    print str
  end

  def cheat
    p @grid
    Board.print_grid(@grid)
    p @grid
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end