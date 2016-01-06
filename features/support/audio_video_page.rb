class AudioVideoPage
  include PageObject

  page_url "http://localhost:4567/audio_video.html"

  audio(:audio_id, :id => 'audio')
  audio(:audio_name, :name => 'audio')
  audio(:audio_class, :class => 'audio')
  audio(:audio_css, :css => '.audio')
  audio(:audio_index, :index => 0)
  audio(:audio_xpath, :xpath => '//audio')
  audio(:audio_class_index, :class => 'audio', :index => 0)
  audio(:audio_name_index, :name => 'audio', :index => 0)

  video(:video_id, :id => 'video')
  video(:video_name, :name => 'video')
  video(:video_class, :class => 'video')
  video(:video_css, :css => '.video')
  video(:video_index, :index => 0)
  video(:video_xpath, :xpath => '//video')
  video(:video_class_index, :class => 'video', :index => 0)
  video(:video_name_index, :name => 'video', :index => 0)

end
