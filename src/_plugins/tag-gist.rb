# Overrides the gist markup added by Jekyll's gist Liquid tag
# to support loading GitHub Gists asynchronously using gist-async from
# https://github.com/razor-x/gist-async

# Must load the jekyll-gist plugin:
# https://github.com/jekyll/jekyll-gist
require 'jekyll-gist'

module Jekyll
  module Gist
    class GistTag
      def gist_script_tag(gist_id, filename = nil)
        file_data_attr =
          filename.empty? ? '' : %( data-gist-file="#{filename}")

        %(<div class="gist" data-gist="#{gist_id}"#{file_data_attr}></div>)
      end
    end
  end
end
