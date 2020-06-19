class ClerksController < ApplicationController
  before_action :ensure_owner

  def new
  end

  def index
    @users = User.where(role: "clerk")
  end
end
