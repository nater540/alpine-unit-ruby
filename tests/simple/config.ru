class HelloKittyIslandAdventure
  def self.call(env)
    [200, {}, 'I like turtles']
  end
end

run HelloKittyIslandAdventure
