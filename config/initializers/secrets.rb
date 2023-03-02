if File.exist?(File.join(Rails.root, "config", "secrets.yml"))
  Rails.application.secrets.merge!(YAML.load_file(File.join(Rails.root, "config", "secrets.yml")))
end
