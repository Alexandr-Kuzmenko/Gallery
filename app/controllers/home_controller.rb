class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  skip_after_action :record_changing
  def index; end
end
