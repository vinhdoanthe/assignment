json.extract! submission_grade, :id, :assignment_id, :student_id, :status, :submission_file_id, :attempt_count, :latest, :mentor_id, :grade_status, :graded_rubric_id, :graded_file_id, :point, :created_at, :updated_at
json.url submission_grade_url(submission_grade, format: :json)
