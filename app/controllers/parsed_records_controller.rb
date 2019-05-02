class ParsedRecordsController < ApplicationController
  def index
    @duplicate_records = parser.duplicate_records.to_json
    @unique_records = parser.unique_records.to_json
  end

  private

  def parser
    RecordLinkerService.new(csv_path)
  end

  def csv_path
    @csv_path ||= "#{Pathname.new File.expand_path('../..', __dir__)}/lib/normal.csv"
  end
end
