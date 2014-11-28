INTEGRATION_TASKS = %w(
  jumpup:heroku:start
  jumpup:start
  jumpup:bundle_install
  db:migrate
  spec
  jumpup:heroku:finish
  jumpup:finish
)
