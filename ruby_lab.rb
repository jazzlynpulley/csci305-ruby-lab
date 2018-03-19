
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Jazzlyn Pulley
# jazzlyn406@gmail.com
#
###############################################################

$bigrams = Hash.new(0) # The Bigram data structure
$name = "Jazzlyn Pulley"

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
array1 = []
pairs = ['','']

	begin
	
		IO.foreach(file_name) do |line|
			array1 = cleanup_title(line).split #splits words into elements of an array
			# print array1 
		
			i = 0
			array1.each_index do |i| #loop to iterate through all arrays
		
				if (i < array1.length-1)
		
					pairs.push([array1[i], array1[i+1]])
					
					#print pairs
				end	
			end	
		
		
		 #print(cleanup_title(line))	
		 
		end
		
		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
	#store the arrays of size 2 into the hash
	pairs.each { | v | $bigrams.store(v, $bigrams[v]+1) }
		
create_title('love')
end
	
#calculates most common word
def mcw(word)
	winningWord = ''
	inputCount = 0 #keeps track of how many times key word is used
	seqCount = 0 #keeps track of sequential matches
	
	$bigrams.each do |key,value| #you want to iterate through every bigram
		if (key[0] == word)
			
			inputCount += 1
			
			if (value >= seqCount)
				#puts(key[1])
				
				seqCount = value
				winningWord = key[1]
					
			end
		end
	end	

	#puts(inputCount)
	#puts(winningWord)
	#puts(highCount)
	return winningWord
end

def create_title(wordyWord)
	count = 0
	title1 = ''
	while (count < 20)
		title1 += wordyWord + " "
		wordyWord = mcw(wordyWord)
		count += 1
		end
	print(title1)
end


# extracts song title and stores it to the variable title
def cleanup_title(myString)
	title = myString.sub(/^.+>/,'')
	
	# remove  (  [  {  \  /  _  -  :  "  `  +  =  *  feat.
	
	title = title.sub(/\(.+|\[.+|\{.+|\\.+|\/.+|\_.+|\-.+|\:.+|\".+|\'.+|\+.+|\=.+|\*.+|(feat.).+/, '')
	
	title = title.downcase # makes lowecase
	
	# remove  ?  ¿  !  ¿  .  ;  &  @  %  #  |
	
	title = title.gsub(/\?|\¿|\!|\.|\;|\&|\@|\%|\#|\|/, '')
	
	#remove non-english -- but never got to work
	
	#if(title.match(/[^'\w\s]/))
	#	title = ''
	#end
	
	# remove stop words  a, an, and, by, for, from, in, of, on, or, out, the, to, with

	title = title.gsub(" a " , " ")
	title = title.gsub(" an " , " ")
	title = title.gsub(" and " , " ")
	title = title.gsub(" by " , " ")
	title = title.gsub(" for " , " ")
	title = title.gsub(" from " , " ")
	title = title.gsub(" in " , " ")
	title = title.gsub(" of " , " ")
	title = title.gsub(" on " , " ")
	title = title.gsub(" or " , " ")
	title = title.gsub(" out " , " ")
	title = title.gsub(" the " , " ")
	title = title.gsub(" to " , " ")
	title = title.gsub(" with " , " ")
	
	return title
	
	
end


# Executes the program
def main_loop()

	puts "CSCI 305 Ruby Lab submitted by Jazzlyn Pulley"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# get user input
	
	#print "Enter a word or q to quit: "
	begin
		print "Enter a word or q to quit: "
		userInput = STDIN.gets.chomp
		create_title(userInput)
	end while userInput!='q'
end

if __FILE__==$0
	main_loop()
end
