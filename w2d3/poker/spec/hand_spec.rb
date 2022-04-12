require 'hand'

describe 'Hand' do
  subject(:hand) { Hand.new } 
  let (:other_hand) { Hand.new }
  let (:card1) {double("card", :value => 2, :suite => 'club')}
  let (:card2) { double("card", :value => 3, :suite => 'club')}
  let (:card3) { double("card", :value => 4, :suite => 'club')}
  let (:card4) { double("card", :value => 5, :suite => 'club')}
  let (:card5) { double("card", :value => 6, :suite => 'club')}
  let (:card6) { double("card", :value => 7, :suite => 'club')}
  let (:card7) { double("card", :value => 6, :suite => 'heart')}
  let (:card8) { double("card", :value => 10, :suite => 'heart')}

  context 'correctly prescribes hand values' do
    it 'gives a straight flush a value of 8' do
      hand.take_cards([card1, card2, card3, card4, card5])
      expect(hand.value).to eq(8)
    end
    it 'gives a four kind a value of 7' do
      hand.take_cards([card1, card1, card1, card1, card2])
      expect(hand.value).to eq 7
    end
    it 'gives a full house a value of 6' do
      hand.take_cards([card1, card1, card1, card2, card2])
      expect(hand.value).to eq 6
    end
    it 'gives a flush a value of 5' do 
      hand.take_cards([card1, card2, card3, card4, card6])
      expect(hand.value).to eq 5
    end

    it 'gives a straight a value of 4' do
      hand.take_cards([card1, card2, card3, card4, card7])
      expect(hand.value).to eq 4
    end
    it 'gives a three kind a value of 3' do
      hand.take_cards([card1, card1, card1, card2, card7])
      expect(hand.value).to eq 3
    end
    it 'gives a two pair a value of 2' do
      hand.take_cards([card1, card1, card2, card2, card7])
      expect(hand.value).to eq 2
    end
    it 'gives a pair a value of 1' do
      hand.take_cards([card1, card1, card2, card3, card7])
      expect(hand.value).to eq 1
    end
    it 'gives a high card a value of 0' do
      hand.take_cards([card8, card2, card3, card4, card7])
      expect(hand.value).to eq 0
    end
  end
  
  context 'it handles tiebreakers properly' do
    it 'returns 0 on a tie' do
      hand.take_cards([card1, card2, card3, card4, card5])
      other_hand.take_cards([card1, card2, card3, card4, card5])
      expect(hand <=> other_hand).to eq 0
    end

    it 'returns 1 when self is greater' do
      hand.take_cards([card1, card1, card2, card2, card8])
      other_hand.take_cards([card1, card1, card2, card2, card7])
      expect(hand <=> other_hand).to eq 1
    end

    it 'returns -1 when self is lesser' do
      hand.take_cards([card1, card1, card2, card2, card7])
      other_hand.take_cards([card1, card1, card2, card2, card8])
      expect(hand <=> other_hand).to eq -1
    end
  end
end
