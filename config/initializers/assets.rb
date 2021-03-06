# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Rails.application.config.assets.precompile += %w( submission_grades/filter_submissions.js )
Rails.application.config.assets.precompile += %w( application.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( devise/new_session.js )
Rails.application.config.assets.precompile += %w( adminlte.min.js adminlte.min.css daterangepicker.js daterangepicker.css moment.min.js submission_grades.js submission_grades.css graded_rubrics.css icheck-bootstrap.min.css )
