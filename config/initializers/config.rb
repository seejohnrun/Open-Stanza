CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV].symbolize_keys
