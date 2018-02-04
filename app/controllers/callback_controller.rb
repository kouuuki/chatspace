class CallbackController < ApplicationController
  # def callback
  #   if params["hub.verify_token"] == "hogehoge"
  #     render json: params["hub.challenge"]
  #   else
  #     render json: "Error, wrong validation token"
  #   end
  # end

  def callback
    binding.pry
    token = "EAAOucPomWPoBAFMahDF2U3HGwaHdp1ZCmZAbh9WUFjQ9jMWK1W9cz42NqrUNoV4LOy7mfmHPTiyPnvicjerOCabmUzlOEhjvzKkwE2Szq0lyBKtfCIks8NlZAFkTWPP6WaheYelm7iEk6hyYw6qoXsyFNe0GktxckSZBAZBRrL9dEY3cvnEnXldMiA4Tq0eoZD"

    message = params["entry"][0]["messaging"][0]
    # p params
    # p message
    # puts "テストです"



    if message.include?("message")

      #ユーザーの発言

      sender = message["sender"]["id"]
      text = message["message"]["text"]

      endpoint_uri = "https://graph.facebook.com/v2.6/me/messages?access_token=" + token
      request_content = {recipient: {id:sender},
                         message: {text: text}
                        }

      content_json = request_content.to_json
      RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8'
      }){ |response, request, result, &block|
        p response
        p request
        p result
      }
    else
      #botの発言
      return text
      p "こんにちは"
    end
  end
end
