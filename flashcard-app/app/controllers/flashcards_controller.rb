class FlashcardsController < ApplicationController
    
    def index
       @flashcards = Current.user.flashcard
    end
    
    def new
        @flashcard = Flashcard.new
    end

    def create
        puts 1
        @flashcard = Flashcard.create(flashcard_params)
        @flashcard.user = Current.user
        if @flashcard.save
            puts 2
            redirect_to root_path, notice: "Success."
        else
            puts 3
            render :new, status: :unprocessable_entity, notice: "Failed."
        end

    end

    private def flashcard_params 
        params.expect(flashcard: [ :question, :answer ])
    end 
    
end
