class RelationshipsController < ApplicationController
  before_filter :require_user
  def index
    @relationships = current_user.is_following
    @leader = current_user.is_leading
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if relationship.is_following == current_user
    redirect_to people_path, notice: "You have successfully removed the user you were following."
  end

end