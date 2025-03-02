class CsvProcessor
  include Interactor::Organizer

  organize CsvReader, CsvParser
end
