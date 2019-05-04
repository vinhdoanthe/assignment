require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminAssignMentor
end

module RailsAdmin
  module Config
    module Actions
      class AssignMentor < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
      end
    end
  end
end