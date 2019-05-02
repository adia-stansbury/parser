require 'csv'

class RecordLinkerService
  private

  attr_reader :csv_path

  public

  def initialize(csv_path)
    @csv_path = csv_path
  end

  def duplicate_records
    duplicate_records = []

    parsed_records.each_pair do |email, value|
      records_for_email = value['records']
      records_for_email.shift

      duplicate_records << records_for_email unless records_for_email.empty?
    end

    duplicate_records
  end

  def unique_records
    unique_records = []

    parsed_records.each_pair do |email, value|
      unique_records << value['records'].first
    end

    unique_records
  end

  def parsed_records
    parsed_records = {}

    CSV.foreach(csv_path, headers: true) do |row|
      row_hash = row.to_h
      email_metaphone = Text::Metaphone.metaphone(row_hash['email'])

      if parsed_records.has_key?(email_metaphone)
        parsed_records[email_metaphone]['records'] << row_hash
      else
        parsed_records[email_metaphone] = {}
        parsed_records[email_metaphone]['records'] = [row_hash]
      end
    end

    parsed_records
  end
end
