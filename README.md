# PgIndexWhere

When create unique index on PostgreSQL, you can speficy WHERE statement as you know.

pg_index_where will provide this function with migrate the database.

## Installation

Add this line to your application's Gemfile:

    gem 'pg_index_where'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pg_index_where

## Usage

Add this option your migrate files.

    :where => 'deleted_at is null'
   
Examples.

    class AddIndex < ActiveRecord::Migration
      def up
        add_index "customers", ["code"], :name => "customers_idx01", :unique => true, :where => 'deleted_at is null'
      end
      
      def down
        remove_index "customers", :name => "customers_idx01"
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
