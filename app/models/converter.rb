require 'csv'

class Converter

  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks ## need for before_validation
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :json_object 
  validates :json_object, 
  			presence: true 

  validate :languages_is_array 



  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  # to create model without databse
  def persisted?
    false
  end


  def get_csv_file
    attributes = json_object.map {|x| x.keys}.flatten.uniq
    CSV.generate(headers: true) do |csv|
      csv << attributes

      json_object.each do |json_ob|
        csv << attributes.map{ |attr| json_ob[attr] }
      end
    end    
  end 

  private

    def languages_is_array
      if valid_json?(json_object)
       self.json_object = JSON.parse(json_object)
      elsif !self.json_object.blank?
        errors.add(:json_object, "must be an array")        
      end

    end

    def valid_json?(json)
      JSON.parse(json)
      return true
    rescue JSON::ParserError => e
      return false
    end

end 