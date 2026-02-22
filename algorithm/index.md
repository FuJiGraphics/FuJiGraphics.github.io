---
layout: main
title: 알고리즘
main: true
---

<div class="loading-animation2">

{% include hashtag.html base_url="/algorithm" tag_group="algorithm" %}

<ul class="catalogue">
{% assign sorted = site.posts | sort: 'date' | reverse | where: 'type', 'algorithm' %}
{% for page in sorted %}
  {% include post-list.html %}
{% endfor %}
{% include post-list-empty.html %}

</ul>
</div>