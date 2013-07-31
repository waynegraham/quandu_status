#! /usr/bin/env ruby

require 'curb'
require 'awesome_print'


module WebTests

  class Validation

    def check_urls(urls = {})
      errors = Array.new

      urls.each do |project, url|
        result = curl_check(url)
        errors.push(project) unless result.response_code == 200
        ap "#{project}, #{result.total_time}, #{result.response_code}" if $DEBUG
      end

      errors

    end

    private

    def curl_check(url)
      Curl::Easy.new(url) do |curl|
        curl.ssl_verify_peer = false
        curl.ssl_verify_host = false
        #curl.verbose if $DEBUG
        #curl.use_ssl = Curl::CURL_USESSL_NONE
        curl.perform
      end
    end
  end

end

$DEBUG = true

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
  'prosody-iframe' => 'http://sdsv1.its.virginia.edu:8080/prosody/exercise.jsp?poem=Wordsworth%20-%20A%20Slumber%20Did%20My%20Spirit%20Seal.xml',
  #'prosody-iframe' => 'http://staging.prosody.lib.virginia.edu:8080/prosody/exercise.jsp?poem=Wordsworth%20-%20A%20Slumber%20Did%20My%20Spirit%20Seal.xml',
  'salem' => 'http://salem.lib.virginia.edu/texts/tei/BoySalCombined',
  'ships' => 'http://staging.ships.lib.virginia.edu',
  'twain' => 'http://staging.twain.lib.virginia.edu',
  'womensbios' => 'http://staging.womensbios.lib.virginia.edu',
  'cocoon' => 'http://sdsv1.its.virginia.edu:8080/cocoon/',
  'geoserver' => 'http://sdsv1.its.virginia.edu:8080/geoserver/web/',
  'metaphors_solr' => 'http://sdsv1.its.virginia.edu:8080/metaphors_solr/select/?q=food%0D%0A&version=2.2&start=0&rows=10&indent=on',
  'solr' => 'http://sdsv1.its.virginia.edu:8080/solr/',
  'numishare_solr' => 'http://sdsv1.its.virginia.edu:8080/solr/numishare-published/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on',
  'faulkner_solr' => 'http://sdsv1.its.virginia.edu:8080/solr/faulkner/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on',
  'latvian' => 'http://sdsv1.its.virginia.edu:8080/solr/latvian/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on',
  'salem' => 'http://sdsv1.its.virginia.edu:8080/solr/salem/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on',
  'salisbury' => 'http://sdsv1.its.virginia.edu:8080/solr/salisbury/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on',
  'womensbios' => 'http://sdsv1.its.virginia.edu:8080/solr/womensbios/select/?q=*%3A*&version=2.2&start=0&rows=10&indent=on'

}

errors = WebTests::Validation.new.check_urls(urls)

puts ""
ap "Errors:"

errors.each do |project|
  ap "#{project}: #{urls[project]}"
end

