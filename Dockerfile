FROM ruby:3.1.6

WORKDIR /backend

COPY . .

RUN ["/bin/bash", "-c", "bundle config --global silence_root_warning 1"]
RUN ["/bin/bash", "-c", "bundle"]
CMD ["/bin/bash", "-c", "rails db:create && rails db:migrate && rails log:clear tmp:clear && rails s -p 3000 -b '0.0.0.0'"]