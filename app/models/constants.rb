# frozen_string_literal: true

module Constants
  
  STR_TRUE = 'true'
  STR_FALSE = 'false'

  SUBMISSION_GRADE_STATUS_OPEN = 'open'
  SUBMISSION_GRADE_STATUS_SUBMITTED = 'submitted'
  SUBMISSION_GRADE_STATUS_ASSIGNED = 'assigned'
  SUBMISSION_GRADE_STATUS_TAKEN_BACK = 'taken back'
  SUBMISSION_GRADE_STATUS_PASSED = 'passed'
  SUBMISSION_GRADE_STATUS_NOT_PASSED = 'not passed'

  # course instance statuses
  COURSE_INSTANCE_STATUS_DEVELOPING = 'developing'
  COURSE_INSTANCE_STATUS_ACTIVE = 'active'
  COURSE_INSTANCE_STATUS_INACTIVE = 'inactive'
  COURSE_INSTANCE_LOCALE_VI = 'vi'
  COURSE_INSTANCE_LOCALE_EN = 'en'

  # user roles
  USER_ROLE_ADMIN = 'admin'
  USER_ROLE_MENTOR = 'mentor'
  USER_ROLE_LEARNER = 'learner'
  USER_ROLE_HANNAH = 'hannah'

  # user statuses
  USER_STATUS_ACTIVE = 'active'
  USER_STATUS_INACTIVE = 'inactive'

  # assignment statuses
  ASSIGNMENT_STATUS_ACTIVE = 'active'
  ASSIGNMENT_STATUS_INACTIVE = 'inactive'

  # submit type of assignment
  ASSIGNMENT_SUBMIT_TYPE_FILE = 'file'
  ASSIGNMENT_SUBMIT_TYPE_NOFILE = 'nofile'
  # grade type of assignment
  ASSIGNMENT_GRADE_TYPE_DEFAULT = 'default'
  ASSIGNMENT_GRADE_TYPE_INTERVIEW = 'interview'

  # enrollment statuses
  ENROLLMENT_STATUS_ACTIVE = 'active'
  ENROLLMENT_STATUS_PENDING = 'pending'
  ENROLLMENT_STATUS_UNENROLL = 'unenroll'
  ENROLLMENT_STATUS_COMPLETED = 'completed'
  ENROLLMENT_STATUS_STOPPED = 'stopped'

  # program statuses
  PROGRAM_STATUS_ACTIVE = 'active'
  PROGRAM_STATUS_INACTIVE = 'inactive'

  # course statuses
  COURSE_STATUS_ACTIVE = 'active'
  COURSE_STATUS_INACTIVE = 'inactive'

  # rubric statuses
  RUBRIC_STATUS_ACTIVE = 'active'
  RUBRIC_STATUS_INACTIVE = 'inactive'

  # criteria types
  CRITERIA_TYPE_POINT = 'point'
  CRITERIA_TYPE_PASS_FAIL = 'pass fail'

  # graded criteria statuses
  GRADED_CRITERIA_STATUS_NOTGRADED = 'not graded'
  GRADED_CRITERIA_STATUS_PASSED = 'passed'
  GRADED_CRITERIA_STATUS_FAILED = 'failed'

  # CRITERIA_MAX_POINT = 5

  # graded rubric statuses
  # GRADED_RUBRIC_STATUS_NOTGRADED = 'not graded'
  GRADED_RUBRIC_STATUS_PASSED = 'passed'
  GRADED_RUBRIC_STATUS_FAILED = 'failed'

  KHAO_THI_EMAIL = 'funix-daotao@funix.edu.vn'
end
