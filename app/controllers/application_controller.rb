# frozen_string_literal: true

#
# ApplicationController
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_base_variables

  def set_base_variables
    @main_title = 'Ongaku Box'
  end
end
