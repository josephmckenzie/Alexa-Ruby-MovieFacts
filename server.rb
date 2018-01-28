#require 'sinatra'
#require 'json'
#
#post '/' do 
#  parsed_request = JSON.parse(request.body.read)
#
#  # Print the incoming request
#  p parsed_request
#  
#  # Send back a simple response
#  return { 
#      version: "1.0",
#      response: {
#        outputSpeech: {
#            type: "PlainText",
#            text: "This is the first question"
#          }
#      }
#    }.to_json
#end

require 'sinatra'
require 'json'

post '/' do 
  parsed_request = JSON.parse(request.body.read)
  this_is_the_first_question = parsed_request["session"]["new"] || parsed_request["session"]["attributes"].empty?
p parsed_request
 if this_is_the_first_question
 return { 
    version: "1.0",
    # here, we can persist data across multiple requests and responses
    sessionAttributes: {
    numberOfRequests: 1
  },
   response: {
    outputSpeech: {
      type: "PlainText",
      text: "This is the first question."
    }
  }
}.to_json
 end

    if parsed_request["request"]["intent"]["name"] == "AMAZON.StartOverIntent"
    p parsed_request["request"]["intent"]["name"]
  return {
    version: "1.0",
    # adding this line to a response will
    # remove any Session Attributes
    sessionAttributes: {},
    response: {
      outputSpeech: {
        type: "PlainText",
        text: "Goodbye"
      },
    
      shouldEndSession: true
    }
  }.to_json
end
    
number_of_requests = parsed_request["session"]["attributes"]["numberOfRequests"] + 1
    puts number_of_requests

return {
  version: "1.0",
  sessionAttributes: {
    numberOfRequests: number_of_requests
  },
  response: {
    outputSpeech: {
      type: "PlainText",
      text: "This is question number #{ number_of_requests }"
    }
  }
}.to_json
    
    


    
    
end