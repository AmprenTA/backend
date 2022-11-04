FROM ruby:3.1.2
WORKDIR /app
COPY . ./
RUN ["/bin/bash", "-c", "bundle config --global silence_root_warning 1"]
RUN ["/bin/bash", "-c", "bundle"]
CMD ["/bin/bash", "-c", "rails db:prepare && rails log:clear tmp:clear && rails s"]
