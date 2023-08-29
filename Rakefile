# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# Disable migration system entirely
Rake::Task.tasks.each do |t|
  if t.name[0,3] == "db:"
      t.clear
      t.add_description("Migration system disabled")
  end
end