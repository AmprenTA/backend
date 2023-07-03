FROM ruby:3.1.2

WORKDIR /backend

COPY . .

RUN ["/bin/bash", "-c", "bundle config --global silence_root_warning 1"]
RUN ["/bin/bash", "-c", "bundle"]
CMD ["/bin/bash", "-c", "rails db:create && rails db:migrate"]
CMD ["/bin/bash", "-c", "rake flights:distances_seed && rake locations:seed"]
CMD ["/bin/bash", "-c", "rails log:clear tmp:clear && rails s -b 0.0.0.0"]
