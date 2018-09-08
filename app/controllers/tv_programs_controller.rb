class TvProgramsController < ApplicationController
  def index
    @tv_programs = current_user.tv_programs.default_order.limit(30)
  end
end
