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
    token = "EAAOucPomWPoBALBWyWKbNT9bhICjg7eq039DW0HpGqGOVE53ShnVax95K08mqeMVzUW8NlJsbEZAnHSJ4ZBKOZCKxFZC6iomcZBwW8kcaoE7Rf8ta6Hi5Lp9DARGhK3lwpXhcO9dlhZCNuAyVp84UbciZA4QCZCvlxiTlm5vz8j5cSQWQ1PxFEZAoZBbPgAZCnFuogZD"

    message = params["entry"][0]["messaging"][0]

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
      p "こんばんは"
    end
  end
end
