class Line
  # {lineID: nil, charID: nil, movieID: nil, quote: nil}
  attr_accessor :lineID, :charID, :movieID, :text
  def initialize(params = {})
    @lineID = params[:lineID]
    @charID = params[:charID]
    @movieID = params[:movieID]
    @quote = params[:quote]
  end

  def save
    def save
    res = DB.execute("SELECT lineID FROM lines WHERE lineID = ?", @lineID).first
    if res.nil?
      DB.execute("INSERT INTO lines (lineID, charID, movieID, quote)
                  VALUES ('#{@lineID}', #{@charID}, '#{@movieID}', '#{@quote}')")
    else
      p "double at #{@lineID}"
      # DB.execute("UPDATE lines
      #             SET url = '#{@url}', votes = #{@votes}, title = '#{@title}'
      #             WHERE id = #{@id}")
    end
  end
  end
end
