class StatusesController < InheritedResources::Base
  before_filter :authenticate_user!


  protected
  def begin_of_association_chain
    @current_user = current_user
  end
end
