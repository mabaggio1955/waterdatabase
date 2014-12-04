S3FileField.config do |c|
  c.access_key_id = ENV['AMAZON_ACCESS_KEY_ID']
  c.secret_access_key = ENV['AMAZON_SECRET_ACCESS_KEY']
  c.bucket = ENV['AMAZON_S3_BUCKET']
  # c.url = ENV['CDN_URL_PREFIX'] if ENV['CDN_URL_PREFIX'].present? # S3 API endpoint (optional), eg. "https://#{bucket}.s3.amazonaws.com/"
  c.region = 's3-sa-east-1' # note the 's3-' prefix; defaults to 's3' US Standard
  # c.acl = "public-read"
  # c.expiration = 10.hours.from_now.utc.iso8601
  # c.max_file_size = 100.megabytes
  # c.conditions = []
  # c.key_starts_with = 'uploads/
  # c.ssl = true # if true, force SSL connection
end
