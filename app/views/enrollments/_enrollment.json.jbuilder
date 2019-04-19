json.extract! enrollment, :id, :user_id, :course_instance_id, :start_date, :end_date, :is_active, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
