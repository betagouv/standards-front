require "types/evaluation_questions_type"

ActiveRecord::Type.register(:questions, EvaluationQuestionsType)
