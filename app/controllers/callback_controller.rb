class CallbackController < ApplicationController
  # def callback
  #   if params["hub.verify_token"] == "hogehoge"
  #     render json: params["hub.challenge"]
  #   else
  #     render json: "Error, wrong validation token"
  #   end
  # end

  def callback
    token = "EAAOucPomWPoBAFMahDF2U3HGwaHdp1ZCmZAbh9WUFjQ9jMWK1W9cz42NqrUNoV4LOy7mfmHPTiyPnvicjerOCabmUzlOEhjvzKkwE2Szq0lyBKtfCIks8NlZAFkTWPP6WaheYelm7iEk6hyYw6qoXsyFNe0GktxckSZBAZBRrL9dEY3cvnEnXldMiA4Tq0eoZD"

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
      # text
      # p "こんにちは"
      if text == "天気"
        button_structured_message_request_body(sender, "いつの天気？", *weather_buttons)
      end
    end
  end

  def button_structured_message_request_body(sender, text, *buttons)
  {
    recipient: {
      id: sender
    },
    message: {
      attachment: {
        type: "template",
        payload: {
          template_type: "button",
          text: text,
          buttons: buttons
        }
      }
    }
  }.to_json
end

def weather_buttons
  [
    {
      type: "postback",
      title: "今日",
      payload: "today_weather"
    },
    {
      type: "postback",
      title: "明日",
      payload: "tomorrow_weather"
    },
    {
      type: "web_url",
      url: "http://www.jma.go.jp/jp/week/319.html",
      title: "その他"
    }
  ]
end
end
