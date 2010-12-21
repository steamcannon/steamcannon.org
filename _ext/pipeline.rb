require 'documentation'
require 'steps'
require 'release_helper'

Awestruct::Extensions::Pipeline.new do
  extension Documentation.new
  helper Steps
  helper ReleaseHelper
end
