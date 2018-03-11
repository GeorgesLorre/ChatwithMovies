require 'sqlite3'

db = SQLite3::Database.new('db/movies.db')

db.execute <<-SQL
           create table lines(
           lineID varchar,
           convoID varchar,
           quote varchar
         );
        SQL

db.execute <<-SQL
           create table convos(
           convoID varchar,
           convosize varchar
         );
        SQL
