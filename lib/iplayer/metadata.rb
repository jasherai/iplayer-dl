require 'rexml/document'

module IPlayer
class Metadata

  METADATA_URL = 'http://www.bbc.co.uk/iplayer/metafiles/episode/%s.xml'

  def initialize(pid, browser)
    @pid = pid
    @browser = browser
  end

  def metadata
    @metadata ||= REXML::Document.new( @browser.get(METADATA_URL % @pid).body )
  end

  def title
    REXML::XPath.first(metadata, '//iplayerMedia/concept/title').text
  end

  def subtitle
    REXML::XPath.first(metadata, '//iplayerMedia/concept/subtitle').text rescue nil
  end

  def full_title
    [title, subtitle].compact.join(' - ')
  end

end
end
