require_relative 'day_1_inputs'

def run(array = input_array)
  counter = 0

  array.each_with_index do |input, index|
    counter += 1 if index != 0 && input > array[index - 1]
  end

  counter
end

def sum_arrays
  return @sum_arrays if defined? @sum_arrays
  @sum_arrays = begin
    input_array.each_with_index.map do |input, index|
      number_array = input_array[index..(index + 2)]
      next if number_array.size < 3
      number_array.inject(0, :+)
    end.compact
  end
end

def input_array
  Inputs.defaults
end

puts "Day 1 part 1 solution #{run}"
puts "Day 1 part 2 solution #{run(sum_arrays)}"
