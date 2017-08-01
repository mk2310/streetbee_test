# StreetBee Test
## Start

```sh
docker-compose up
```
In worksheet_registry app console
```sh
bundle exec rake db:create db:migrate
```
## API`s
For uploading images:
```
POST, '/worksheet_registry/attachments'
```
received params like
```ruby
{
  '0': file,
  ...
}
```
For user registry:
```
POST, /worksheet_registry/users
```
received params like
```ruby
user: {
  first_name: string,
  second_name: string,
  login: string,
  password: string
}
```
For sign in:
```
POST, /worksheet_registry/users/sign_in
```
received params like
```ruby
login: {
  login: string,
  password: string
}
```
For worksheet list:
```
GET, /worksheet_registry/worksheets
```
received params like
```ruby
login: {
  login: string,
  password: string
}
```
For worksheet view:
```
GET, /worksheet_registry/worksheets/:id
```
received params like
```ruby
{
  id: id,
  login: {
    login: string,
    password: string
  }
}
```
For answer:
```
PUT, /worksheet_registry/worksheets/:id
```
received params like
```ruby
{
  id: id,
  decision: boolean,
  login: {
    login: string,
    password: string
  }
}
```
