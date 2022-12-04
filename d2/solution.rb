require 'debug'
require 'ostruct'

# str_guide = <<~INPUT
#   A Y
#   B X
#   C Z
# INPUT

str_guide = IO.read('input.txt')
# binding.break

opponent_plays = {
  'A' => 'Rock'    ,
  'B' => 'Paper'   ,
  'C' => 'Scissors',
}

game_expectation = {
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win,
}

win_rules = {
  'Scissors' => 'Paper',
  'Paper' => 'Rock',
  'Rock' => 'Scissors',
}

lose_rules = win_rules.invert

play_score = {
  'Rock' => 1,
  'Paper' => 2,
  'Scissors' => 3,
}

round_scores = {
  lost: 0,
  draw: 3,
  win: 6,
}


results = str_guide.split("\n").map do |play|
  o_coded_play, m_coded_play = play.split

  o_play = opponent_plays[o_coded_play]

  round_expectation = game_expectation[m_coded_play]

  m_play = case round_expectation
  when :draw
    o_play
  when :lose
    win_rules[o_play]
  else
    lose_rules[o_play]
  end

  o_play_score = play_score[o_play]
  m_play_score = play_score[m_play]

  round_result = if o_play == m_play
    :draw
  elsif win_rules[o_play] == m_play
    :lost
  else
    :win
  end

  # binding.break
  round_score = m_play_score + round_scores[round_result]

  OpenStruct.new(o_play:, m_play:, round_score:)
end

# puts results
puts results.sum(&:round_score)
