class HomeController < ApplicationController
  def index
    render json: {
      message: 'Check README.rdoc for more info'
    }
  end
end
