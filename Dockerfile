# syntax = docker/dockerfile:1

# Start from the official Ruby image
FROM ruby:3.2.4

# Install Node.js and Yarn (needed for Rails asset compilation)
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Set the working directory
WORKDIR /myapp

# # Set production environment
# ENV RAILS_ENV="production" \
#    BUNDLE_DEPLOYMENT="1" \
#    BUNDLE_PATH="/usr/local/bundle" \
#    BUNDLE_WITHOUT="development"

# Add the Gemfile and Gemfile.lock to the image
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN bundle install

# Copy the rest of the application into the image
COPY . /myapp

# Expose the port that the Rails server will run on
EXPOSE 3000

# Define the command to start the server
CMD ["rails", "server", "-b", "0.0.0.0"]


# # Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
# ARG RUBY_VERSION=3.2.4
# FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
#
# # Rails app lives here
# WORKDIR /rails
#
# # Set production environment
# ENV RAILS_ENV="production" \
#     BUNDLE_DEPLOYMENT="1" \
#     BUNDLE_PATH="/usr/local/bundle" \
#     BUNDLE_WITHOUT="development"
#     SECRET_KEY_BASE=your_generated_secret_key
#
#
# # Throw-away build stage to reduce size of final image
# FROM base as build
#
# # Install packages needed to build gems
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config
#
# # Install application gems
# COPY Gemfile Gemfile.lock ./
# RUN bundle install && \
#     rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#     bundle exec bootsnap precompile --gemfile
#
# # Copy application code
# COPY . .
#
# # Precompile bootsnap code for faster boot times
# RUN bundle exec bootsnap precompile app/ lib/
#
#
# # Final stage for app image
# FROM base
#
# # Install packages needed for deployment
# RUN apt-get update -qq && \
#     apt-get install --no-install-recommends -y curl libvips postgresql-client && \
#     rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
# # Install Node.js and Yarn (needed for Rails asset compilation)
# RUN apt-get update -qq && apt-get install -y nodejs yarn
#
# # Copy built artifacts: gems, application
# COPY --from=build /usr/local/bundle /usr/local/bundle
# COPY --from=build /rails /rails
#
# # Run and own only the runtime files as a non-root user for security
# RUN useradd rails --create-home --shell /bin/bash && \
#     chown -R rails:rails db log storage tmp
# USER rails:rails
#
# # Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
# # Start the server by default, this can be overwritten at runtime
# EXPOSE 3000
# CMD ["./bin/rails", "server"]
