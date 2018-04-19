## Setup
1. Open terminal
2. `cd rails-project-builder`
3. `ruby build.rb`
4. Enter project name
5. Enter table name
6. Configure migration file
7. `rails db:migrate`
8. `rails server`

### Additional Setup Info
- Create new controller
- Create corresponding views folder
- Create index.html.erb inside folder

### Change Root View Page
1. open `routes.rb` within the 'config' folder
2. add `root 'examples#index'`
3. add 'resources :examples'

```ruby
Rails.application.routes.draw do
  root 'examples#index'
  resources :examples
end
```


## Features
- [x] adds necessary gems to Gemfile
- [x] creates spec folder with rails_helper & spec_helper
- [x] adds should matcher configuration to rails_helper
- [x] creates migration file
- [ ] configures migration file based on the columns requested
- [ ] generates basic model/controller/view

![work-in-progress](https://media.giphy.com/media/3o7btQ0NH6Kl8CxCfK/giphy.gif)

### Changelog
- v. 1.0.0
