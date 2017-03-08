# Ruby + Unicorn + Nginx + Nodejs

Add `unicorn` in your Gemfile and the following into your `application.rb` or `production.rb`:

```
logger               = ActiveSupport::Logger.new(STDOUT)
logger.formatter     = config.log_formatter
config.logger        = ActiveSupport::TaggedLogging.new(logger)
```

Example Dockerfile:

```
FROM puzzle/ose3-unicorn
COPY . /usr/src/app
RUN scl enable rh-ruby23 "bundle install --path .bundle"
```

This image is supposed to be minimal. If you need advanced configuration options please `COPY` your own Nginx or Unicorn configuration to the respective locations, but open a pull request if you think it would be a sensible default.

If you want to split the Nginx proxy and Unicorn process you can directly specify the commands in `Procfile` as seperate Docker CMDs.
