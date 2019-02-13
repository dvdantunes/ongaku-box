# Procfile for Foreman
#
# Note: if needed, you can run these commands in separate shells instead of using foreman
#
# @see http://blog.daviddollar.org/2011/05/06/introducing-foreman.html


# Main app
web: puma -C config/puma.rb

# Sidekiq job handler
job: sidekiq -C config/sidekiq.yml.erb
