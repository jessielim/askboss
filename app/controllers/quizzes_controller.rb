class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    if params[:action] == "dashboard"
      @quizzes = Quiz.where(user_id: current_user.id)
    else
      @quizzes = Quiz.all
    end
    
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

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @problems = Problem.where(quiz_id: @quiz.id)
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    @quiz.problems.build.solutions.build
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.tag_list.add(params[:quiz][:tag_list], parse: true)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :user_id, tag_list: [], problems_attributes: [ :question, :quiz_id, :solutions_attributes => [:answer, :correct, :problem_id] ])
    end
end
