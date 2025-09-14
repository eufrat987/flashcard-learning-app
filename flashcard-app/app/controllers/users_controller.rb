class UsersController < ApplicationController
    allow_unauthenticated_access

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        @user.session = 1

        if @user.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end

    end

    def reset_learning_session
        @user = User.find(params[:id])
        @user.session = 1
        @user.flashcard.each do |card|
          card.bucket = 1
          card.save
        end 
        if @user.save
            redirect_to root_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    private def user_params
      params.expect(user: [ :email_address, :password ])
    end

end
