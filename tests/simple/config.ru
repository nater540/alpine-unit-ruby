class SimpleApplication
  def self.call(env)
    [200, {}, 'Hello Universe!']
  end
end

run SimpleApplication
