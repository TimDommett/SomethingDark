#for now make it just a bunch of objects - later put it into script so can just read it off

class Script
  attr_accessor :scene, :options
  attr_reader :options
    def initialize(scene, options)
      @scene = scene
      @options = options
    end

end
