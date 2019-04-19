json.extract! course_instance, :id, :code, :name, :description, :start_date, :end_date, :program_id, :course_id, :status, :created_at, :updated_at
json.url course_instance_url(course_instance, format: :json)
