# movie lines : - lineID - characterID - movieID - text of the utterance
#
# linehash = {lineID: nil, charID: nil, movieID: nil, text: nil}
require 'sqlite3'

DB = SQLite3::Database.open("movies.db")

def clean_input(inpt)
  inpt.encode!('UTF-8', :invalid => :replace, :undef => :replace)
  inpt.strip.gsub('"', "'").gsub("'","\\'" ).split(' +++$+++ ')
end

# readlines docu
def build_line_table
  DB.execute("DELETE FROM lines")
  counter = 0
  now = Time.now.to_i
  File.readlines('../rawdata/movie_lines.txt').each do |x|
    t = clean_input(x)
    DB.execute("INSERT INTO lines (lineID, convoID, quote)
      VALUES (?,?,?) "  , t[0], "n/a", t[4])
    counter += 1
    if counter % 5000 == 0
      p "lines:#{counter} @ #{(Time.now.to_i - now)}ms"
    end
  end
  p "Finished!! lines:#{counter} @ #{(Time.now.to_i - now)}ms"
end

def build_convo_table
  DB.execute("DELETE FROM convos")
  counter = 0
  now = Time.now.to_i

  File.readlines('../rawdata/movie_conversations.txt').each do |x|
    t = x.strip.split(' +++$+++ ')
    t[3] = t[3][1..-2].split(',').map{|s| s.strip[1..-2] }

    DB.execute("INSERT INTO convos (convoID, convosize)
      VALUES (?,?) "  , t[0], t[3].size)

    t[3].each do |y|
      DB.execute("UPDATE lines
        SET convoID = ?
        WHERE lineID = ?" , t[0], y)
    end

    counter += 1
    if counter % 100 == 0
      p "lines:#{counter} @ #{(Time.now.to_i - now)}ms"
    end
  end
  p "Finished!! lines:#{counter} @ #{(Time.now.to_i - now)}ms"
end

build_convo_table
