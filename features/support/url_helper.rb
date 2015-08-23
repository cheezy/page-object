module UrlHelper
  class << self
    def html
      File.expand_path("#{File.dirname(__FILE__)}/../html")
    end

    def files
      target = ENV['BROWSER']
      return "file://#{html}" if target.nil? or target.include? 'local'
      'http://ec2-107-22-131-88.compute-1.amazonaws.com'
    end

    def static_elements
      "#{files}/static_elements.html"
    end
    
    def frame_elements
      "#{files}/frames.html"      
    end
    
    def iframe_elements
      "#{files}/iframes.html"
    end
    
    def nested_frame_elements
      "#{files}/nested_frames.html"
    end
    
    def nested_elements
      "#{files}/nested_elements.html"
    end
    
    def modal
      "#{files}/modal.html"
    end

    def async
      "#{files}/async.html"
    end

    def multi
      "#{files}/multi_elements.html"
    end

    def indexed
      "#{files}/indexed_property.html"
    end

    def hover
      "#{files}/hover.html"
    end

    def double_click
      "#{files}/double_click.html"
    end

    def widgets
      "#{files}/widgets.html"
    end
  end
end
