module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      def add_index(table_name, column_name, options = {})
        where = options[:where] ? "where #{options[:where]}" : ''
        index_name, index_type, index_columns = add_index_options(table_name, column_name, options)
        execute "CREATE #{index_type} INDEX #{quote_column_name(index_name)} ON #{quote_table_name(table_name)} (#{index_columns}) #{where}"
      end
    end
  end
end
