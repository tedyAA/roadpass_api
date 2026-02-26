# Use official Ruby image
FROM ruby:3.3.3

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile first (for caching)
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy entire app
COPY . .

# Expose Rails port
EXPOSE 3000

# Start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]