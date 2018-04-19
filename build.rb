#!/usr/bin/ruby
require 'fileutils'

class Project
  def initialize(project_name, table_name)
    @project_name = project_name
    @table_name = table_name
  end

  def build
    system "rails new #{@project_name}"
    FileUtils.cd '..'
    puts FileUtils.pwd

    FileUtils.cd "#{@project_name}"

    # Adds necessary gems to Gemfile
    File.open('Gemfile', 'a+') do |f|
      f << "\n"
      f << "# gems added through rails-project-builder\n"
      f << "gem 'jquery-rails'\n"
      f << "gem 'bootstrap', '~> 4.0.0.beta2.1'\n"
      f << "gem 'rspec-rails'\n"
      f << "gem 'launchy'\n"
      f << "gem 'pry'\n"
      f << "gem 'shoulda-matchers'\n"
      f << "gem 'capybara'\n"
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

    # Creates Database
    system "rails db:create"

    # Creates migration file
    system "rails g migration create #{@table_name}"

    system "rails db:migrate"

  end
end

puts "Enter Project Name: "
project_name = gets.chomp
puts "Enter Table Name (must be plural):  "
table_name = gets.chomp

# eventually allows the user to generate tables
# puts "Enter Table Name:"
# puts "Enter Column Names and Datatypes"
project = Project.new(project_name, table_name)
project.build
