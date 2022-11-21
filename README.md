## Local installation

Steps to follow in order to setup the app locally:

```sh
rvm use ruby-3.1.2@amprenta [--create]
bundle [install]
rails db:create
rails db:migrate
```

## Local testing
- Run the server: `rails s`
- Open the browser and go to:
```sh
http://127.0.0.1:3000
```
- Swagger API:
```sh
http://127.0.0.1:3000/docs
```
