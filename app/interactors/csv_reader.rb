require "csv"
require "open-uri"

class CsvReader
  include Interactor

  def call
    file_url = context.csv_url

    begin
      context.csv_content = URI.open(file_url).read
    rescue OpenURI::HTTPError => e
      context.fail!(error: "Failed to fetch CSV from URL: #{e.message}")
    rescue StandardError => e
      context.fail!(error: "An error occurred: #{e.message}")
    end
  end
end
