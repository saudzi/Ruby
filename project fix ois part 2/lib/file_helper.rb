# FileHelper
module FileHelper
  def self.open_read(file_name)
    raise "File #{file_name} not found" unless File.exist?(file_name)

    File.open(file_name, 'r')
  rescue StandardError => e
    warn e.message
    abort
  end
end
