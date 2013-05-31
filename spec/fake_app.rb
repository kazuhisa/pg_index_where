# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller'
require 'pg_index_where'
require 'acts_as_paranoid'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'postgresql', :database => 'test_pg_index_where',
                                                :min_messages => 'WARNING'}}
ActiveRecord::Base.establish_connection('test')

# models
class Customer < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :name, :code
end
