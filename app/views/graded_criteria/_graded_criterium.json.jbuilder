json.extract! graded_criterium, :id, :graded_rubric_id, :description, :point, :required, :status, :comment, :created_at, :updated_at
json.url graded_criterium_url(graded_criterium, format: :json)
