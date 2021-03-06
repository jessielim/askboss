class UsersController < Clearance::UsersController
  # include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :set_user, only: [:dashboard, :show, :edit, :update, :destroy]

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @questions = Question.where(user_id: @user.id)
    @answers = Answer.where(user_id: @user.id)
    @notes = Note.where(user_id: @user.id)
    @flashcards = FlashCard.where(user_id: @user.id)
    @quizzes = Quiz.where(user_id: @user.id)
  end

  def dashboard
    @user = current_user
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    @questions = Question.where(user_id: current_user.id)
    @answers = Answer.where(user_id: current_user.id)
    @notes = Note.where(user_id: current_user.id)
    @flashcards = FlashCard.where(user_id: current_user.id)
    @quizzes = Quiz.where(user_id: current_user.id)
  end

  def edit
  	@user = User.find(params[:id])
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: 'User profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
      # if profile_check
      #   redirect_back_or url_after_create
      # else
      #   redirect_to edit_user_path
      # end
    else
      render template: "users/new"
    end
  end

 #  def user_from_params
	#   user_params = params[:user] || Hash.new
	#   email = user_params.delete(:email)
	#   password = user_params.delete(:password)
	#   first_name = user_params.delete(:first_name)
	#   last_name = user_params.delete(:last_name)
	#   avatar = user_params.delete(:avatar)

	#   Clearance.configuration.user_model.new(user_params).tap do |user|
	#     user.email = email
	#     user.password = password
	#     user.first_name = first_name
	#     user.last_name = last_name
	#     user.avatar = avatar
	#   end
	# end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

 
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :role, :qualification, :verified)
    end
end

