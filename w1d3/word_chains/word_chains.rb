class WordChainer

  def self.dict_from_file(dict_file)
    dict = {}
    File.foreach(dict_file) { |line| dict[line.chomp] = true }
    dict
  end

  def initialize(dict_file)
   @dict = WordChainer.dict_from_file(dict_file)
   @current_words = []
   @all_seen_words = {}
  end

  def adjacent_words(word)
    @dict.keys.select { |adj| adjacent?(word, adj) }
  end

  def adjacent?(wrd1, wrd2)
    return false unless wrd1.length == wrd2.length
    diffs = 0
    (0...wrd1.length).each { |i| diffs += 1 unless wrd1[i] == wrd2[i] }
    diffs == 1
  end

  def run(source, target)
    @current_words << source
    @all_seen_words[source] = nil
    until @current_words.empty?
      @current_words = explore_current_words(target)
    end
    build_path(target)
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        next if @all_seen_words.key? adj_word

        new_current_words << adj_word
        @all_seen_words[adj_word] = current_word
        return [] if @all_seen_words.key?(target)
      end
    end
    # new_current_words.each { |word| puts "#{word} : #{@all_seen_words[word]}"}
    new_current_words
  end

  def build_path(target)
    return nil unless @all_seen_words.key?(target)

    path = []
    until target.nil?
      path << target
      target = @all_seen_words[target]
    end
    path
  end
end

w = WordChainer.new('dictionary.txt')
p w.run('cat', 'bro')