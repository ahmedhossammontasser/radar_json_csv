require 'rails_helper'
require 'pp'
describe "ApiController", type: :request do
  describe "post index" do
    
    it "return status 400 for json_object not being array " do
      post '/api/convert?json_object=name'
      response_body =  JSON(response.body)
      expect(response).to have_http_status(400)
      expect(response_body['errors']["json_object"]).to eq(["must be an array"])
    end

    it "return status 400 for empty input" do
      post '/api/convert?json_object='
      response_body =  JSON(response.body)
      expect(response).to have_http_status(400)
      expect(response_body['errors']["json_object"]).to eq(["can't be blank"])
    end

    # [ {"name": "bed", "color": "black", "size": "12", "date_created": "12/6", "condition": "New"}, 
    #   {"name": "chair", "color": "brown", "size": "7", "date_created": "6/13", "condition": "Used"},
    #   {"name": "desk", "color": "maple", "size": "9", "date_created": "2/13" , "add":"1111"}
    # ]
    it "return status 200 input 1" do
      post "/api/convert?json_object=[%20%7B%22name%22:%20%22bed%22,%20%22color%22:%20%22black%22,%20%22size%22:%20%2212%22,%20%22date_created%22:%20%2212/6%22,%20%22condition%22:%20%22New%22%7D,%20%7B%22name%22:%20%22chair%22,%20%22color%22:%20%22brown%22,%20%22size%22:%20%227%22,%20%22date_created%22:%20%226/13%22,%20%22condition%22:%20%22Used%22%7D,%7B%22name%22:%20%22desk%22,%20%22color%22:%20%22maple%22,%20%22size%22:%20%229%22,%20%22date_created%22:%20%222/13%22%20,%20%22add%22:%221111%22%7D]"
      expect(response).to have_http_status(200)
      pp '====response.body===='
      pp response.body
      pp '====end===='
      pp "            "
      expect(response.body).to eq("name,color,size,date_created,condition,add\nbed,black,12,12/6,New,\nchair,brown,7,6/13,Used,\ndesk,maple,9,2/13,,1111\n")
    end

   #  [
   #   {"name": "bed", "color": "black", "size": "12", "date_created": "12/6", "condition": "New"}, 
   #   {"name":"John","age":30,"cars": {"car1":"Ford","car2":"BMW","car3":"Fiat"}}
   # ]
    it "return status 200 input 2" do
      post "/api/convert?json_object=[%20%7B%22name%22:%20%22bed%22,%20%22color%22:%20%22black%22,%20%22size%22:%20%2212%22,%20%22date_created%22:%20%2212/6%22,%20%22condition%22:%20%22New%22%7D,%20%7B%22name%22:%22John%22,%22age%22:30,%22cars%22:%20%7B%22car1%22:%22Ford%22,%22car2%22:%22BMW%22,%22car3%22:%22Fiat%22%7D%7D]"
      expect(response).to have_http_status(200)
      pp '====response.body===='
      pp response.body
      pp '====end===='
      pp "            "
      expect(response.body).to eq("name,color,size,date_created,condition,age,cars\nbed,black,12,12/6,New,,\nJohn,,,,,30,\"{\"\"car1\"\"=>\"\"Ford\"\", \"\"car2\"\"=>\"\"BMW\"\", \"\"car3\"\"=>\"\"Fiat\"\"}\"\n")
    end


   #  [
   #   {"name": "bed", "color": "black", "size": "12", "date_created": "12/6", "condition": "New"}, 
   #   {"name":"John","age":30,"cars": ["Ford","BMW","Fiat"]}
   # ]
    it "return status 200 input 3" do
      post "/api/convert?json_object=[%20%7B%22name%22:%20%22bed%22,%20%22color%22:%20%22black%22,%20%22size%22:%20%2212%22,%20%22date_created%22:%20%2212/6%22,%20%22condition%22:%20%22New%22%7D,%20%7B%22name%22:%22John%22,%22age%22:30,%22cars%22:%20[%22Ford%22,%22BMW%22,%22Fiat%22]%7D]"
      expect(response).to have_http_status(200)
      pp '====response.body===='
      pp response.body
      pp '====end===='
      pp "            "
      expect(response.body).to eq("name,color,size,date_created,condition,age,cars\nbed,black,12,12/6,New,,\nJohn,,,,,30,\"[\"\"Ford\"\", \"\"BMW\"\", \"\"Fiat\"\"]\"\n")
    end


  end
end

