class ErrorsController < ApplicationController
  skip_before_filter :authorize

  def not_found
    render '404', status: 404
  end

  def error
    render '500', status: 500
  end
end
