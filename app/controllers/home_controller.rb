class HomeController < ApplicationController
  skip_before_action :authenticate_user! || :authenticate_admin_user!, only: [:index]
  def index
  end
end
