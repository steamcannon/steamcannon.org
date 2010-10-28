require 'steps'
require 'release_helper'

Awestruct::Extensions::Pipeline.new do
  helper Steps
  helper ReleaseHelper
end
