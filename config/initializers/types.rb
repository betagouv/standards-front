require "types/audit_questions_type"

ActiveRecord::Type.register(:questions, AuditQuestionsType)
