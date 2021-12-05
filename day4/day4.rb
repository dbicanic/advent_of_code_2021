require 'matrix'

def get_file_data
  @get_file_data ||= File.readlines('test_input.txt', chomp: true)
end

def bingo_ball_results
  get_file_data.first.split(',').map(&:to_i)
end

def set_bingo_cards
  temp_array_of_cards = [[]]
  index_of_card = 0
  array_of_cards = []

  get_file_data.drop(2).each do |row|
    if row.empty?
      array_of_cards << Matrix[*temp_array_of_cards[index_of_card]]
      index_of_card += 1
    else
      temp_array_of_cards << [] if array_of_cards[index_of_card].nil?
      temp_array_of_cards[index_of_card] << row.split(' ').map(&:to_i)
    end
  end

  array_of_cards << Matrix[*temp_array_of_cards[index_of_card]]

  array_of_cards
end

def return_first_valid_bingo_card
  # first_bingo_winner = []

  bingo_ball_results.each_with_index do |bingo_ball, index|
    next if index < 5

    set_bingo_cards.each do |bingo_card|
      bingo_card.to_a.each do |card_row|
        if (card_row - bingo_ball_results[0..index]).empty?
          return { bingo_ball => bingo_card, numbers_to_remove: bingo_ball_results[0..index] }
        end
      end

      5.times do |n|
        if (bingo_card.column(n).to_a - bingo_ball_results[0..index]).empty?
          return { bingo_ball => bingo_card, numbers_to_remove: bingo_ball_results[0..index] }
        end
      end
    end
  end
end

def sum_of_card_and_times
  bingo_hash = return_first_valid_bingo_card
  winning_ball = bingo_hash.keys.first

  total = Array(bingo_hash[winning_ball]).flatten - bingo_hash[:numbers_to_remove]

  return total.sum * winning_ball
end

print sum_of_card_and_times

