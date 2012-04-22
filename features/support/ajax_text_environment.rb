require File.dirname(__FILE__) + "/../sample-app/sample_app"

class AjaxTestEnvironment
  def run
    Thread.abort_on_exception = true
    @example_app = Thread.new { SampleApp.start("127.0.0.1", 4567) }
    poller = Selenium::WebDriver::SocketPoller.new("127.0.0.1", 4567, 60)
    unless poller.connected?
      raise "timed out waiting for SampleApp to launch"
    end

    self
  end

  def stop
    @example_app.kill
  end

end

@server = AjaxTestEnvironment.new
@server.run

at_exit do
  @server.stop
end
