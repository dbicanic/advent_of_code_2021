def input_array
  @input_array ||= File.readlines('input.txt').map { |e| e.to_s.strip }
end

def total_row_count(array = input_array)
  @total_row_count ||= array.size
end

def half_row_count
  total_row_count / 2
end

def split_array(array = input_array)
  array.map do |number|
    number.chars
  end
end

def most_common(base_array = input_array)
  return @gamma if defined? @gamma
  @gamma = begin

    gamma_string = ''

    split_array.first.size.times do |n|
      gamma_string += ((total_row_count(base_array) - base_array.map { |row| row[n].to_i }.inject(0, :+)) < half_row_count ? '1' : '0')
    end

    gamma_string
  end
end

def gamma(binary_array = split_array)
  gamma_string = ''

  binary_array.first.size.times do |n|
    counter = 0

    binary_array.each do |row|
      result = row[n] == '1' ? 1 : -1
      counter += result
    end

    gamma_string += counter >= 0  ? '1' : '0'
  end

  gamma_string
end


def epsilon(binary_array = split_array)
  gamma_string = ''

  binary_array.first.size.times do |n|
    counter = 0

    binary_array.each do |row|
      result = row[n] == '1' ? 1 : -1
      counter += result
    end

    gamma_string += counter < 0  ? '1' : '0'
  end

  gamma_string
end

def answer_decimal
  scrub_gen.to_i(2) * scrub_gen(epsilon, :epsilon).to_i(2)
end

def scrub_gen(scrubbed = most_common, type = :gamma, array = input_array, index = 0)
  keep_array = []

  array.each do |element|
    keep_array << element if element.chars[index] == scrubbed.chars[index]
  end

  if keep_array.size == 1
    return keep_array.first
  elsif keep_array.size == 2 && keep_array.first.chars.size == index + 1
    return keep_array.first if keep_array.first.chars[index] == '1'
    retrun keep_array.last
  end

  scrub_gen(public.send(type, (split_array(keep_array))), type, keep_array, index + 1)
end


puts answer_decimal
