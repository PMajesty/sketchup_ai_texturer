require 'sketchup.rb'
require 'extensions.rb'

module ArtyomYurkov
  module AiTexturer
    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('AI Texture Generator', 'sketchup_ai_texturer/main')
      ex.description = 'Texture generation'
      ex.version = '1.0.0'
      ex.copyright = '2026, Artyom Yurkov'
      ex.creator = 'Artyom Yurkov'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end
  end
end
