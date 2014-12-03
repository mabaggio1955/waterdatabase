Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:bucket] = ENV['AMAZON_S3_BUCKET']
Paperclip::Attachment.default_options[:s3_permissions] = :public_read
Paperclip::Attachment.default_options[:s3_credentials] = {
  :access_key_id => ENV['AMAZON_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
}
