# frozen_string_literal: true

module Audits
  class API < Grape::API
    format :json

    helpers do
      def startup_audit
        Audit.find_by!(startup: EspaceMembre::Startup.find_by!(ghid: params[:startup_id]))
      rescue ActiveRecord::RecordNotFound
        error! :not_found, 404
      end
    end

    resource :audit do
      params do
        requires :startup_id, type: String, desc: "GitHub identifier of the startup"
      end

      desc "Return the startup's audit"
      get do
        startup_audit
      end

      desc "Return the summary of the startup's audit"
      get :summary do
        startup_audit.completion_stats
      end
    end

    add_swagger_documentation
  end
end
