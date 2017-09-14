
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => S3_ACCESS,
      :aws_secret_access_key  => S3_SECRET,
      :region                 => 'us-east-2' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "medce"
end