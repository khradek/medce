CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIIZUJMWG7O3WQ2FQ",
      :aws_secret_access_key  => "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",
      :region                 => 'us-east-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "medce"
end