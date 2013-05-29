module ActiveRecord
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

          index_where = index_with_where(index.name)
          statement_parts << (':where => ' + index_where.inspect) unless index_where.nil?

          '  ' + statement_parts.join(', ')
        end

        stream.puts add_index_statements.sort.join("\n")
        stream.puts
      end
    end

    def index_with_where(name)
      sql = <<-EOS
        select pg_get_expr(i.indpred, i.indrelid) from pg_class c
        inner join pg_index i on c.oid = i.indexrelid
        where c.relname = '#{name}';
      EOS
      query_result = @connection.exec_query(sql).first
      query_result ? query_result['pg_get_expr'] : nil
    end
  end
end
