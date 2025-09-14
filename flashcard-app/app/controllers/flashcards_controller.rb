class FlashcardsController < ApplicationController
    
    def index
       @flashcard = Current.user.flashcard.first
       redirect_to show_flashcard_path(@flashcard)
    end

    def show
        @flashcard = Flashcard.find(params[:id])
    end

    def success
        @flashcard = Flashcard.find(params[:id])
        redirect_to root_path
    end

    def fail
        @flashcard = Flashcard.find(params[:id])
        redirect_to root_path
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
