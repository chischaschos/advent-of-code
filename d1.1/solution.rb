require 'debug'

inventory = IO.read('input.txt')

elf_index = 1
max = nil
elf_with_max = nil

# TODO: how to lazy enumerators work?
inventory.split(/\n\n/).to_enum.map do |match|
  # binding.break
  total = match.split.map(&:to_i).sum

  if total > max.to_i
    elf_with_max = elf_index
    max = total
  end

  elf_index += 1
end

puts elf_index
puts elf_with_max
puts max
