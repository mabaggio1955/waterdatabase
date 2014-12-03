Paperclip::Attachment.default_options.merge!({
  :storage => :s3,
  :bucket => ENV['AMAZON_S3_BUCKET'],
  :s3_permissions => :public_read,
  :s3_credentials => {
    :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
  }
}) unless Rails.env.test?
