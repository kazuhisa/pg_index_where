require 'pg_index_where/version'

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

  class SchemaDumper
    private
    def indexes(table, stream)
      if (indexes = @connection.indexes(table)).any?
        add_index_statements = indexes.map do |index|
          statement_parts = [
            ('add_index ' + remove_prefix_and_suffix(index.table).inspect),
            index.columns.inspect,
            (':name => ' + index.name.inspect),
          ]
          statement_parts << ':unique => true' if index.unique

          index_lengths = (index.lengths || []).compact
          statement_parts << (':length => ' + Hash[index.columns.zip(index.lengths)].inspect) unless index_lengths.empty?

          index_orders = (index.orders || {})
          statement_parts << (':order => ' + index.orders.inspect) unless index_orders.empty?

          index_where = index_with_where(table, index.name)
          statement_parts << (':where => ' + index_where.inspect) unless index_where.nil?

          '  ' + statement_parts.join(', ')
        end

        stream.puts add_index_statements.sort.join("\n")
        stream.puts
      end
    end

    def index_with_where(table, name)
      sql = <<-EOS
        SELECT distinct i.relname, pg_get_indexdef(d.indexrelid)
                   FROM pg_class t
                   INNER JOIN pg_index d ON t.oid = d.indrelid
                   INNER JOIN pg_class i ON d.indexrelid = i.oid
                   WHERE i.relkind = 'i'
                     AND d.indisprimary = 'f'
                     AND t.relname = '#{table}'
                     AND i.relnamespace IN (SELECT oid FROM pg_namespace WHERE nspname = ANY (current_schemas(false)) )
                     AND i.relname = '#{name}'
                  ORDER BY i.relname
      EOS
      query_result = @connection.exec_query(sql).first
      return nil unless query_result
      query_result['pg_get_indexdef'] =~ /WHERE \((.+)\)$/
      $1
    end
  end
end

