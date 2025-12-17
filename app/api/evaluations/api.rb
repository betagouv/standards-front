# frozen_string_literal: true

module Evaluations
  class API < Grape::API
    format :json

    helpers do
      def startup_evaluation
        Evaluation.find_by!(startup: EspaceMembre::Startup.find_by!(ghid: params[:startup_id]))
      rescue ActiveRecord::RecordNotFound
        error! :not_found, 404
      end
    end

    resource :evaluations do
      desc "Return all evaluations"
      get do
        Evaluation
          .includes(:startup)
          .all
          .map(&:presented)
          .map(&:to_index_api)
          .reduce({}, :merge)
      end
    end

    resource :evaluation do
      params do
        requires :startup_id, type: String, desc: "GitHub identifier of the startup"
      end

      desc "Return the startup's evaluation"
      get do
        startup_evaluation
      end

      desc "Return the summary of the startup's evaluation"
      get :summary do
        startup_evaluation.completion_stats
      end
    end

    add_swagger_documentation
  end
end
