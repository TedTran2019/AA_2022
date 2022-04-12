require 'tdd_projects'

describe 'tdd_projects' do
  describe '#my_uniq' do
    subject(:array) { [1, 2, 1, 3, 3]}

    it 'removes dups' do
      expect(array.my_uniq).to eq([1, 2, 3])
    end
  end

  describe '#two_sum' do
    subject(:array) {[-1, 0, 2, -2, 1]}

    it 'finds all pairs of positions where elements sum to zero' do
      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe 'my_transpose' do 
    subject(:matrix) {[
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]}

    it 'tranposes the matrix' do
      expect(matrix.my_transpose).to eq matrix.transpose
    end
  end
  describe 'stock_picker' do
    subject(:prices) {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}

    it 'chooses the most profitable pairs of days to buy/sell' do 
      expect(stock_picker(prices)).to eq([[0, 9]])
    end
  end

  describe 'Towers of Hanoi' do
    subject(:game) { TowersOfHanoi.new }
    describe 'initialization' do 
      it 'correctly initializes the instance variables' do
        expect(game.stack1).to eq([3, 2, 1])
        expect(game.stack2).to be_empty
        expect(game.stack3).to be_empty
        expect(game.nbr_discs).to eq(3)
      end
    end

    describe 'move' do
      it 'raises error when trying to take from empty stack' do
        expect {game.move([2, 0])}.to raise_error("Can't take from empty stack!")
      end
      it 'raises error when trying to place onto smaller disc' do
        game.stack3 << 0
        expect {game.move([0, 2])}.to raise_error("Can't place onto smaller disc!")
      end
      it 'correctly places smaller disc onto larger one or empty stack' do
        game.move([0, 1])
        game.move([0, 2])
        expect(game.stack1.first).to eq(3)
        expect(game.stack2.first).to eq(1)
        expect(game.stack3.first).to eq(2)
      end
    end

    describe 'won?' do 
      context 'has not won' do 
        it 'returns false' do
          expect(game.won?).to be false
        end
      end

      context 'has won' do 
        it 'returns true' do
          3.times { game.stack1.pop }
          game.stack2.concat([1, 2, 3])
          expect(game.won?).to be true
        end
      end
    end
  end
end
