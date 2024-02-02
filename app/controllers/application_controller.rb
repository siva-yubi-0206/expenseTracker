class ApplicationController < ActionController::Base
    include Pundit
    def current_user
      Thread.current[:user]
    end
end
  
