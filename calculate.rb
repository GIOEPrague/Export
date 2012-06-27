#!/usr/bin/env ruby

load 'config.rb'

file = File.open("top_night_coder.txt", "rb")
contents = file.read

lines = contents.split("\n")

teams = []
results = []

lines.each_with_index do |line, line_index|
	next if line_index == 0 or line_index == 1

	numbers = line.split "\t"
	
  weighted_line = [] 
	numbers.each_with_index do |number, index|
		if index != 0
		  weighted_number = number.strip.to_f * multipliers[index-1].to_f
			print "#{weighted_number.round(2)}\t"
			weighted_line << weighted_number	
		else
			teams << number.split[0] if line_index > 2 and number.split[0].length > 6
			teams << "#{number.split[0]}\t" if line_index > 2 and number.split[0].length <= 6
			print "#{number}\t" if number.split[0].length > 6
			print "#{number}\t\t" if number.split[0].length <= 6
		end
	end
	
	if line_index > 2
		sum = 0
		weighted_line.each do |number_item|
			sum += number_item.to_f if !number_item.eql?("")
		end
		
		print " | #{sum.round(2)}"
		results << sum.round(2) 
	end
	
	puts
end

puts lines[2]

teams.each_with_index do |v, i|
	puts "#{v}\t| #{results[i]}"
end

puts lines[2]

puts "Winner is #{teams[results.find_index(results.max)]} with #{results.max} points!"