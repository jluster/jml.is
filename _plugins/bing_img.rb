require "location"
require "net/https"
require "uri"
require "json"

module JekyllBingStaticImagePlugin
  class BingStaticImageTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super

      @text    = text
      tokens  = @text.split /\,\s/
      @params = {}

      tokens.each do |arg|
        key, value = arg.split /:/
        value ||= "1"
        @params[key.strip] = value.strip
      end
    end

    def render(context)
      @config  = context.registers[:site].config["bing"]
      @api_key = @config["api_key"]
      if @api_key.nil?
        raise BingTagError "You must provide a Bing api key."
      end

      my_loc = BingLocator.new()
      my_loc.api_key = @api_key

      my_loc.query = @params['q']
      size = @params['s'] ||= '900,300'
      s = size.split /,/
      lurl = my_loc.get_img_url_by_query(s[0],s[1])
      "<img src='#{lurl}' width='#{s[0]}' />"
    end
  end
end

Liquid::Template.register_tag('bingmap', JekyllBingStaticImagePlugin::BingStaticImageTag)
