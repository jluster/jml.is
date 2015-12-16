require 'instagram'

module Jekyll
  class InstagramTag < Liquid::Tag

    def initialize(tag_name, config, token)
      @config = Jekyll.configuration({})['instagram'] || {}
    end

    def render(context)
      container = ""
      photos.each do |photo|
        container = container + "<img src='#{photo.images.thumbnail.url}' />"
      end
      container
    end

    def photos
      client = Instagram.client(:access_token => @config['access_key'])
      user = client.user
      client.user_recent_media
    end

  end
end

Liquid::Template.register_tag('instagram', Jekyll::InstagramTag)
