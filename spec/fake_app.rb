# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller/railtie'
require 'action_view/helpers'
require 'pg_index_where'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'postgresql', :database => 'test_pg_index_where'}}
ActiveRecord::Base.establish_connection('test')

# config
app = Class.new(Rails::Application)
app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
app.config.session_store :cookie_store, :key => "_myapp_session"
app.config.active_support.deprecation = :log
app.initialize!

# routes
app.routes.draw do
  resources :customers
end

# models
class Customer < ActiveRecord::Base
end

# controllers
class ApplicationController < ActionController::Base; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:customers) {|t| t.string :name; t.string :code}
  end
end
