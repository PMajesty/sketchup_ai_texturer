module ArtyomYurkov
  module AiTexturer
    def self.generate_texture
      model = Sketchup.active_model
      selection = model.selection

      if selection.empty?
        UI.messagebox("Please select a Face first!")
        return
      end

      model.start_operation('AI Texture Apply', true)

      textures_path = File.join(__dir__, 'assets', 'textures')
      texture_files = Dir.glob(File.join(textures_path, '*.jpg'))

      if texture_files.empty?
        UI.messagebox("No textures found in directory: #{textures_path}")
        model.abort_operation
        return
      end

      random_texture_file = texture_files.sample
      texture_name = File.basename(random_texture_file, ".*")
      materials = model.materials
      material = materials[texture_name]

      unless material
        material = materials.add(texture_name)
        material.texture = random_texture_file

        if material.texture
          material.texture.size = [1000.mm, 1000.mm]
        end
      end

      count = 0
      selection.grep(Sketchup::Face).each do |face|
        face.material = material
        face.back_material = material
        count += 1
      end

      model.commit_operation

      Sketchup.status_text = "AI Texture: Applied '#{texture_name}' to #{count} faces."
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Generate AI Texture') {
        self.generate_texture
      }
      file_loaded(__FILE__)
    end
  end
end
