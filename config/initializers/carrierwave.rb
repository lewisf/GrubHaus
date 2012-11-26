CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => 'AKIAI54C72SXPLO354QQ',
    :aws_secret_access_key => '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',
    :region => 'us-east-1'
  }
  config.fog_directory = 'grubhaus'
  config.asset_host = 'https://s3.amazonaws.com/grubhaus/'
end
