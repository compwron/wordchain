class Dictionary
	def self.words(word_size=4)
		@words ||= (puts 'Loading dictionary!' ; File.readlines('dict.txt').map{|i| i.strip}.select {|i| i.size == word_size })
	end
end
class WordChain
	def initialize(options)
		@current = options[:current]
		@end_word = options[:end_word]
		@depth = (options[:depth] || 0) + 1
		@max_depth = options[:max_depth]
		@previous_words = (options[:previous_words] || []) + [@current]
		p @previous_words
		@morphs = _morphs
	end
	def _morphs
		p "MORPHING for #{@current }"
		words_for.map { |w|
			if w == @end_word
				puts "#{(@previous_words + [w]).join(' ')}"
				return
			elsif make_new_words?(w)
				# p w
				WordChain.new(_next_options(w))
			end
		}
	end

	def make_new_words?(w)
		@depth < @max_depth && !@previous_words.include?(w)
	end

	def words_for
		Dictionary.words.select{|w| almost?(@current, w)}.reject {|i| i == @current }
	end

	def almost?(a, b)
		a.split('').zip(b.split('')).select {|pair| pair.first != pair.last}.count == 1
	end

	def _next_options(w)
		{
			current: w,
			end_word: @end_word,
			depth: @depth,
			max_depth: @max_depth,
			previous_words: @previous_words
		}
	end
end

if ![2, 3].include?(ARGV.size)
	puts "Usage: \n 	<first word> <last word> <maximum depth>(optional)\n 	ruby bar.rb word bird 3\n 	ruby bar.rb hint bent 2"
	exit
end
starter_word = ARGV[0]
end_word = ARGV[1]
max_depth = ARGV[2] ? ARGV[2].to_i : 2

puts "running with: max_depth #{max_depth}, starter word: #{starter_word}, end word: #{end_word}"

Dictionary.words(starter_word.size)
WordChain.new(current: starter_word, end_word: end_word, max_depth: max_depth)
