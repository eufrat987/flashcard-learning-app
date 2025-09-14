class FlashcardsController < ApplicationController
    
    def index
       @flashcard = Current.user.flashcard.first
       redirect_to show_flashcard_path(@flashcard)
    end

    def all
        @flashcards = Flashcard.all
    end

    def delete
        @flashcard = Flashcard.find(params[:id])
        if Flashcard.delete(@flashcard)
            redirect_to all_flashcards_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end

    def update
        @flashcard = Flashcard.find(params[:id])
        if @flashcard.update(flashcard_params) 
            redirect_to all_flashcards_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end
    
    def edit
        @flashcard = Flashcard.find(params[:id])
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
        @flashcard = Flashcard.create(flashcard_params)
        @flashcard.user = Current.user
        if @flashcard.save
            redirect_to root_path, notice: "Success."
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end

    end

    private def flashcard_params 
        params.expect(flashcard: [ :question, :answer ])
    end 
    
end
