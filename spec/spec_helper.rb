require "chefspec"
require "chefspec/berkshelf"

RSpec.configure do |c|
  c.platform  = "debian"
  c.version   = "7.0"
  c.log_level = :warn
end
