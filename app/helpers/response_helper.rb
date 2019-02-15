# frozen_string_literal: true

#
# Response helper
#
# @see https://gist.github.com/mlanett/a31c340b132ddefa9cca
module ResponseHelper

  # Renders a json response with 200 OK status
  # for the provided object
  #
  # @param [Object] object    Object to convert to json
  # @param [Symbol] status    HTTP status code symbol
  #
  # @return [application/json]
  def json_response(object, status = :ok)
    object = object.kind_of?(Hash) ? object.to_json : object
    render json: object, status: status
  end


  # Renders a json response with 400 Bad request status
  #
  # @param [String] message   Message to send on the response
  #
  # @return [application/json]
  def json_bad_request_response(message)
    message = 'Unable to process your request: '+ message
    render json: {message: message}.to_json, status: :bad_request
  end
end
