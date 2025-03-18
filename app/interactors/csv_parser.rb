require "csv"

class CsvParser
  include Interactor

  def call
    begin
      parsed_data = CSV.parse(context.csv_content, headers: context.headers)
      context.csv_line_items = parsed_data.map(&:to_h)
    rescue StandardError => e
      context.fail!(error: "CSV parsing failed: #{e.message}")
    end
  end
end
