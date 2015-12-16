module Jekyll
  module ZeroFilter
    def zeroize(input, prepend=nil)
      o = input.to_s.rjust(3, "0")
    rescue
      "error"
    end
  end
end

Liquid::Template.register_filter(Jekyll::ZeroFilter)
