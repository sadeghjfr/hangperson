require 'sinatra/base'
require 'sinatra/flash'
require './lib/hangperson_game.rb'

class HangpersonApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || HangpersonGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end
  
  post '/create' do
    word = params[:word] || HangpersonGame.get_random_word

    @game = HangpersonGame.new(word)
    redirect '/show'
  end
  
  post '/guess' do
    letter = params[:guess].to_s[0]
    if(!@game.guess(letter))
      flash[:message]="You have already used that letter"
    end

    redirect '/show'
  end
  
  get '/show' do

    
    status = @game.check_win_or_lose
    if status == :win
		redirect "/win";
  	end
	
  	if status == :lose
		redirect "/lose";
  	end
	
  	@wrong_guesses = @game.wrong_guesses
  	@word_with_guesses = @game.word_with_guesses

    erb :show 
  end
  
  get '/win' do

    if @game.check_win_or_lose != :win
      redirect '/show'
    end
    erb :win 
  end
  
  get '/lose' do

    if @game.check_win_or_lose != :lose
      redirect '/show'
    end
    erb :lose 
  end
  
end
