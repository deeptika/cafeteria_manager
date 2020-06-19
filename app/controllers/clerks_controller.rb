class ClerksController < ApplicationController
  def new
  end

  def index
    @users = User.where(role: "clerk")
  end
end
