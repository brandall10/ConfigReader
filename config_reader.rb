# ConfigReader - reads properties from a config file, ignores
#   blank lines and single line comments, processes booleans properly
#
# Ex:
# > load 'config_reader.rb'
# => true
# > test = ConfigReader.new("config_test.txt")
# => <ConfigReader:0x007fc4b98fd4e8>...
# > test.properties
# => ["dir", "num", "boolfalse", "booltrue"] 
# > test["dir"]
# => "/here/there/everywhere"
# > test["boolfalse"]
# => false 

class ConfigReader
  @properties 

  def initialize(file = nil)
    @properties = Hash.new(0)
    process(file) if file
  end

  # parse config file
  def process(file)
    begin
      open(file).each do |line| 
        parse(line)
      end
    rescue 
      p "Can't open file."
    end
  end

  # add to config hash if valid
  def parse(line)

    # ignore comments and blank lines
    unless /^(\s*\#|\s*\n)/.match(line) 

      # only handling case for key/val pairs, other parsing 
      # considerations not defined in spec (ie. inline comments)
      key, val = line.strip.split(/\s*=\s*/)  

      # handle boolean cases
      case val.downcase
      when "on", "true"
        val = true
      when "off", "false"
        val = false
      end

      # golden, add to hash
      @properties[key] = val
    end
  end

  # overload for easy access at object level
  def [](property)
    @properties[property]
  end

  # get a dump of the parsed properties
  def properties
    @properties.keys
  end
end