#! /usr/bin/env ruby

require 'curb'
require 'awesome_print'

projects = %w(abraham alumna )

urls = {
  'abraham' => 'http://staging.abraham.lib.virginia.edu',
  'alumna' => 'http://staging.alumna.lib.virginia.edu/results?prog1=*',
  #'bridge' => 'https://staging.bridge.lib.virginia.edu',
  'coins' => 'http://staging.coins.lib.virginia.edu',
  'cooper' => 'http://staging.cooper.lib.virginia.edu',
  'colonialrevival' => 'http://staging.colonialrevival.lib.virginia.edu',
  'cowley' => 'http://staging.cowley.lib.virginia.edu',
  'falmouth' => 'http://staging.falmouth.lib.virginia.edu',
  'faulkner' => 'http://staging.faulkner.lib.virginia.edu',
  'ibnjubayr' => 'http://staging.ibnjubayr.lib.virginia.edu',
  'jsr' => 'http://staging.jsr.lib.virginia.edu',
  'jsr-forum' => 'http://staging.jsrforum.lib.virginia.edu',
  'jtr' => 'http://staging.jtr.lib.virginia.edu',
  'latvian' => 'http://staging.latviandainas.lib.virginia.edu',
  'metaphors' => 'http://staging.metaphors.lib.virginia.edu',
  'ovid' => 'http://staging.ovid.lib.virginia.edu',
  'prosody' => 'http://staging.prosody.lib.virginia.edu',
  'prosody-iframe' => 'http://staging.prosody.lib.virginia.edu:8080/prosody/exercise.jsp?poem=Wordsworth%20-%20A%20Slumber%20Did%20My%20Spirit%20Seal.xml',
  'salem' => 'http://salem.lib.virginia.edu/texts/tei/BoySalCombined',
  'ships' => 'http://staging.ships.lib.virginia.edu',
  'twain' => 'http://staging.twain.lib.virginia.edu',
  'womensbios' => 'http://staging.womensbios.lib.virginia.edu',

}

errors = Array.new

urls.each do |project, url|

  http = Curl::Easy.new(url) do |curl|
    curl.ssl_verify_peer = false
    curl.perform
  end

  ap "Testing #{project}"
  errors.push(project) unless http.response_code == 200

end

puts ""
ap "Errors:"

errors.each do |project|
  ap "#{project}"
end
