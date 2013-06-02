class ChallengesController < InheritedResources::Base
  before_filter :build_tasks, :only => :new
  def collection
    Challenge.all
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    @challenge.owner = current_user
    @challenge.tasks = @challenge.tasks.reject {|task| task.title.blank?}
    @challenge.tasks.each do |task|
      task.completed = false
      task.user = current_user
    end

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Question was successfully created.' }
        format.json { render json: @challenge, status: :created, location: @challenge }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def build_tasks
    @challenge = Challenge.new
    3.times.each do
      @challenge.tasks << Task.new
    end
  end
  def begin_of_association_chain
    @current_user = current_user
  end
end
