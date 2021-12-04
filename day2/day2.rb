def end_point
  horizontal = 0
  depth = 0
  aim = 0

  input_array.each do |input|
    input_size = input.split.last.to_i

    case input.split.first
    when 'forward'
      horizontal += input_size
      depth += (aim * input_size)
    when 'down'
      aim += input_size
    when 'up'
      aim -= input_size
    end
  end

  horizontal * depth
end

def input_array
  File.readlines('input.txt')
end

puts end_point