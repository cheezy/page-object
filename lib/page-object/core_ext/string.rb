class String
  def is_integer
    true if Integer(self) rescue false
  end
end