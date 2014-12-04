class Document < ActiveRecord::Base
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => /\A.*\Z/
  validates :content, presence: true
  belongs_to :content

  # download_from_direct_url_with_delay :file
  def file_direct_url=(value)
    open(value, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |file|
      self.attributes = {
        file: file,
        file_file_name: File.basename(value),
      }
    end
  end
end
