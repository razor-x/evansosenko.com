//= require console-polyfill
//= require fastclick
//= require headroom.js/dist/headroom
//= require vendor/disqus
//= require _fonts
//= require _init

/* global ga */

'use strict'

{% if jekyll.environment == 'production' %}
  ga('create', '{{ site.data.vendor.google.analytics.id }}', 'auto')
  ga('send', 'pageview')
{% endif %}
