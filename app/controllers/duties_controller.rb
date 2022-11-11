class DutiesController < ApplicationController
  layout "top"
  def index
    @duties = Duty.all
  end
end
