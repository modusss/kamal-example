# Use a official Ruby image as a parent image
FROM ruby:3.0.0-slim as base

# Set the working directory in the container
WORKDIR /rails

# Set environment variables for Rails
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    RAILS_MASTER_KEY=76ffba0370aeea3b6a3971f1f6309674 \
    REDIS_URL=redis://redis_app:6400 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development

# Install system dependencies required for Rails and Apache
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl libsqlite3-0 libvips42 git && \
    apt-get install --no-install-recommends -y apache2 apache2-utils && \
    a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests && \
    rm -rf /var/lib/apt/lists/*

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby gems, including those needed in production
RUN bundle install --without development test

# Copy the main application
COPY . .

# Precompile Rails assets (note: this requires a secret key base environment variable)
RUN SECRET_KEY_BASE_DUMMY=1 RAILS_ENV=production bundle exec rake assets:precompile

# Add a script to start the server and Apache
COPY start-script.sh /start-script.sh
RUN chmod +x /start-script.sh

# Set up Apache virtual host
COPY my-apache-config.conf /etc/apache2/sites-available/000-default.conf

# Make sure the Apache2 PID doesn't exist to avoid startup problems
RUN rm -f /var/run/apache2/apache2.pid

# Expose port 80 to the Docker network
EXPOSE 80

# Set the container to run the start script by default
CMD ["/start-script.sh"]
