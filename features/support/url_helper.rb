module UrlHelper
  class << self
    def html
      File.expand_path("#{File.dirname(__FILE__)}/../html")
    end

    def files
      "file://#{html}"
    end


    def static_elements
      "#{files}/static_elements.html"
    end
    
    def frame_elements
      "#{files}/frames.html"      
    end
  end
end
