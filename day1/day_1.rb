require_relative 'day_1_inputs'

def run
  counter = 0

  Inputs.defaults.each_with_index do |input, index|
    counter += 1 if index != 0 && input > Inputs.defaults[index - 1]
  end

  puts counter
end

run