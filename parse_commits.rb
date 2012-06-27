#!/usr/bin/env ruby

require 'pathname'
load '../../config.rb'

first_project = 'dart-music'

ARGF.each_with_index do |line, idx|
		pn = Pathname.new("#{Dir.pwd}.path").parent.basename
		if idx == 0 and !pn.to_s.eql? ".git" and !pn.to_s.eql? "videos" 
			numbers = line.gsub('>', '> ').gsub( %r{</?[^>]+?>}, '' ).gsub('%', '').split(' ')
			
			i = 0
			if pn.to_s.eql? first_project
				print "Hour\t\t"
				numbers.each_with_index do |number, index|
					print "#{index}\t" if (22..24).include? index or (0..8).include? index
				end
				puts
				i = 0
				print "Multiplier\t"
				numbers.each_with_index do |number, index|
					print "#{multipliers[i]}\t" if (22..24).include? index or (0..8).include? index
					i = 8 if index == 21
					i += 1
				end
				puts
				puts "----------------------------------------------------------------------------------------------------"
			end
		
			print "#{pn}\t"
			if pn.to_s.length <= 5
			  #print "\t"
			end
			numbers.each_with_index do |number, index|
				print "#{number}\t" if (22..24).include? index or (0..8).include? index
			end
			puts
		end
end