class ApiController < ApplicationController

	def convert
		converter = Converter.new({ json_object: params[:json_object] })

		if converter.valid?			
			send_data converter.get_csv_file, filename: "json_to_csv.csv"
		else
			render json: { errors: converter.errors, status: 400 } , status: 400 
		end
	end

end
