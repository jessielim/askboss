class NotesController < ApplicationController
 	def index
 		@notes = Note.all
 		
    respond_to do |format|
      format.js
      format.html { render :index }
    end
	end

	def list
	  @questions = Question.where(user_id: current_user.id)
	  @answers = Answer.where(user_id: current_user.id)
	  @notes = Note.where(user_id: current_user.id)
	  @flashcards = FlashCard.where(user_id: current_user.id)
	  @quizzes = Quiz.where(user_id: current_user.id)
	end

	def new
		@note = Note.new
	end

	def create
		# byebug
		@note = Note.new
		@note.name = params[:note][:name]
		@note.user_id = current_user.id
		@note.libraries=params[:note][:libraries]
		@note.tag_list.add(params[:note][:tag_list], parse: true)
		@note.save
		redirect_to note_path(@note)
	end

	def edit
		# byebug
		@note = Note.find(params[:id])
	end

	def show
		@note = Note.find(params[:id])
	end

	def update
		# byebug
		@note = Note.find(params[:id])
		@note.name = params[:note][:name]
		if params[:note][:libraries]!=nil
			@note.libraries += params[:note][:libraries]
		end				
		@note.save
		flash[:notice]= "Note was successfully updated"
		redirect_to note_path
	end

	def remove
		# byebug
		@note = Note.find(params[:id])
		@note['libraries'].delete_at(params[:count].to_i)
		@note.save
		redirect_to note_path
	end



end