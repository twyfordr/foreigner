module Foreigner
  module ConnectionAdapters
    module SqlserverAdapter
      include Foreigner::ConnectionAdapters::Sql2003

      def remove_foreign_key(table, options)
        if Hash === options
          foreign_key_name = foreign_key_name(table, options[:column], options)
        else
          foreign_key_name = foreign_key_name(table, "#{options.to_s.singularize}_id")
        end

        execute "ALTER TABLE #{quote_table_name(table)} DROP CONSTRAINT #{quote_column_name(foreign_key_name)}"
      end

      def foreign_keys(table_name)
        options = {}
        
        fk_info = select_all %Q{
          SELECT cs_o.name as 'name', cs_col.name as 'column', ref_o.name as 'to_table', ref_col.name as 'primary_key'
          FROM sys.tables as t
            LEFT JOIN sys.foreign_key_columns as fkc ON (fkc.parent_object_id = t.object_id)
            LEFT JOIN sys.objects as cs_o ON (cs_o.object_id = fkc.constraint_object_id)
            LEFT JOIN sys.columns as cs_col ON (cs_col.object_id = fkc.parent_object_id AND cs_col.column_id = fkc.parent_column_id)
            LEFT JOIN sys.objects as ref_o ON (ref_o.object_id = fkc.referenced_object_id)
            LEFT JOIN sys.columns as ref_col ON (ref_col.object_id = fkc.referenced_object_id AND ref_col.column_id = fkc.referenced_column_id)
          WHERE t.name = '#{table_name}'
        }

        fk_info.collect do |row|
          ForeignKeyDefinition.new(table_name, row['to_table'], options)
        end
      end
    end
  end
end 

module ActiveRecord
  module ConnectionAdapters
    SqlserverAdapter.class_eval do
      include Foreigner::ConnectionAdapters::SqlserverAdapter
    end
  end
end
