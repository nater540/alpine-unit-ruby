require 'json'

class JsonApplication
  def self.call(env)
    body = {
      greetings: 'Hello Universe!'
    }

    [200, {"Content-Type" => "application/json"}, [body.to_json]]
  end
end

run JsonApplication
