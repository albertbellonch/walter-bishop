class API::BaseController < ActionController::API
  include ActionController::Serialization

  respond_to :json
end
