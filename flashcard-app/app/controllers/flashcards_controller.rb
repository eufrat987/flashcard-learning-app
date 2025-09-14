class FlashcardsController < ApplicationController
    before_action :set_flashcard, only: %i[ delete update edit show success fail ]

    def index
       @flashcard = Current.user.flashcard.where("bucket <= ?", Current.user.session)
            .order("RANDOM()").limit(1).first
       has_flashcards = Current.user.flashcard.first.present?

       if has_flashcards && !@flashcard.present? 
        Current.user.session += 1
        Current.user.save
        @flashcard = Current.user.flashcard.where("bucket <= ?", Current.user.session)
            .order("RANDOM()").limit(1).first
       end

       if @flashcard.present?
        redirect_to show_flashcard_path(@flashcard)
       else
        redirect_to new_flashcard_path
       end
    end

    def all
        @flashcards = Current.user.flashcard
    end

    def show
    end

    def new
        @flashcard = Flashcard.new
    end

    def create
        @flashcard = Flashcard.create(flashcard_params)
        @flashcard.bucket = 0
        @flashcard.user = Current.user
        if @flashcard.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end

    end
    
    def edit
    end

    def update
        if @flashcard.update(flashcard_params) 
            redirect_to all_flashcards_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end

    def delete
        if Flashcard.delete(@flashcard)
            redirect_to all_flashcards_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end

    def success
        puts @flashcard
        @flashcard.bucket = @flashcard.bucket + 1
        if @flashcard.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end

    def fail
        @flashcard.bucket = 1
        if @flashcard.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity, notice: "Failed."
        end
    end

    private def set_flashcard
        @flashcard = Flashcard.find(params[:id])
    end

    private def flashcard_params 
        params.expect(flashcard: [ :question, :answer ])
    end 
    
end
