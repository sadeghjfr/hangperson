class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word , :guesses , :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(a)
    if (a=='' || a== NIL)
    raise ArgumentError, "No null is allowed"
    end
    if (a.match(/[^A-Za-z]/))
      raise ArgumentError, "No numbers"
    end
    a=a.downcase()
    lists=@word.split("")
    lists.each do |list|
      if(a==list)
        @wrong_guesses+=""
        if(!guesses.include?a)
          @guesses+=a
          return true
        end
        return false
      end
    end
    @guesses+= ''
    if(!@wrong_guesses.include?a)
      @wrong_guesses+=a
      return true
    end
    return false
  end
  
  def word_with_guesses
    current= ''
    var= 0
    ges=@guesses.split("")
    temps=@word.split("")
    temps.each do |temp|
      ges.each do |a|
        if(temp == a)
          current += a
          var = 1
        end
      end
      if (var == 0)
        current += '-'
      end
      var = 0
    end
    return current
  end
  def check_win_or_lose
    count = 0
    temps = @word.split("")
    comps = @guesses.split("")
    temps.each do |temp|
      comps.each do|comp|
      if(comp==temp)
        count += 1
        break
      end
    end
  end
  if (@wrong_guesses.length == 7)
    :lose
  elsif (temps.length == count)
    :win
  else
    :play
  end
  end
end
