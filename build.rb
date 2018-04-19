#!/usr/bin/ruby
require 'fileutils'

class Project
  def initialize(project_name, table_name)
    @project_name = project_name
    @table_name = table_name
  end

  def build
    FileUtils.cd '..'
    system "rails new #{@project_name}"
    puts FileUtils.pwd

    FileUtils.cd "#{@project_name}"

    # Adds necessary gems to Gemfile
    File.open('Gemfile', 'a+') do |f|
      f << "\n"
      f << "# gems added through rails-project-builder\n"
      f << "gem 'jquery-rails'\n"
      f << "gem 'bootstrap'\n"
      f << "gem 'bootstrap-sass'\n"
      f << "gem 'rspec-rails'\n"
      f << "gem 'launchy'\n"
      f << "gem 'pry'\n"
      f << "gem 'shoulda-matchers'\n"
    end

    # Creates spec folder with rails_helper and spec_helper
    system "bundle exec rails generate rspec:install"

    # Adds Shoulda Matcher functionality
    File.open('spec/rails_helper.rb', 'a+') do |f|
      f << "Shoulda::Matchers.configure do |config|\n"
      f << "  config.integrate do |with|\n"
      f << "    with.test_framework :rspec\n"
      f << "    with.library :rails\n"
      f << "  end\n"
      f << "end\n"
    end

    # installs gems
    system 'bundle install'

    # updates gems
    # system 'bundle update'

    # adds bootstrap functionality
    FileUtils.cd("app/assets/stylesheets/")
    File.rename('application.css', 'application.scss')
    File.open('application.scss', 'a+') do |f|
      f << "@import 'bootstrap';"
    end
    FileUtils.cd('../../..')
    # Creates Database
    system "rails db:create"

    # Creates migration file
    system "rails g migration #{@table_name}"
  end
end

puts "Enter Project Name:\n"
project_name = gets.chomp
puts "Enter db:migrate file name (must be plural)\nexample => create_examples_table or create_examples:\n"
table_name = gets.chomp
project = Project.new(project_name, table_name)
project.build
