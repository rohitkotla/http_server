FROM ruby:latest
EXPOSE 8080
COPY httpserver.rb .
CMD ruby httpserver.rb