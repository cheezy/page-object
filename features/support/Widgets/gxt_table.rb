
class GxtTable < PageObject::Elements::Table
  protected
  def child_xpath
    ".//descendant::tr"
  end
end
