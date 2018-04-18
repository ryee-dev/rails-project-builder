#!/usr/bin/ruby
require 'fileutils'

class Project
  def initialize(project_name)
    @project_name = project_name
  end

  def build
    system "rails new #{@project_name}"
    FileUtils.cd '..'
    puts FileUtils.pwd

    FileUtils.cd("#{@project_name}")

    File.open('Gemfile', 'a') do |f|
      f << "gem 'jquery-rails'\n"
      f << "gem 'bootstrap', '~> 4.0.0.beta2.1'\n"
      f << "gem 'rspec-rails'\n"
      f << "gem 'launchy'\n"
      f << "gem 'pry'\n"
      f << "gem 'shoulda-matchers'\n"
      f << "gem 'capybara'\n"
    end
  end
end


puts "Enter Project Name: "
project_name = gets.chomp

# eventually allows the user to generate tables
# puts "Enter Table Name:"
# puts "Enter Column Names and Datatypes"
project = Project.new(project_name)
project.build
