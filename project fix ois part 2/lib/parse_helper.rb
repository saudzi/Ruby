# ParseHelper
module ParseHelper
  require 'date'
  def self.parse_date(dd_mm_yyyy)
    Date.strptime(dd_mm_yyyy, '%d.%m.%Y')
  rescue StandardError => e
    warn e.message
  end
end
