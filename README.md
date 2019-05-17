# README

## Gems used in this project
* devise for Authentication
* rails_admin for admin panel
* rails_admin_import for import from excel file
* paper_trail for track audits
* act_as_paranoid for soft deleted (to-do)
* enumerize for enum types in model & sql
* cancancan for authorization (to-do)
## Settings that needs configure on production enviroment
* sidekiq
* redis
* action mailer
* whenever
* config
* figaro

## To do features
* Show progress in uploading files
* Send email
* Cron job for checking expired submissions/grades
* #### Add field "type" to criteria_format: point, pass_failed, interval,...
* Use concerns & callbacks for sending email 
  * https://medium.freecodecamp.org/add-callbacks-to-a-concern-in-ruby-on-rails-ef1a8d26e7ab
* Bulk assign mentor 
  * https://stackoverflow.com/questions/11525459/customize-rails-admin-delete-action-for-a-specific-model
  * https://www.endpoint.com/blog/2012/03/15/railsadmin-custom-action-case-study
  * http://ec2-52-77-8-173.ap-southeast-1.compute.amazonaws.com/2016/03/08/custom-actions-with-rails-admin/
  * https://coderwall.com/p/4utlyg/how-to-create-a-custom-section-for-railsadmin-engine
  * https://blog.codeminer42.com/writing-custom-railsadmin-actions-e0799aadc8ae