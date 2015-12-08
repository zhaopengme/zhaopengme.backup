{% if theme.use_motion %}

  <script type="text/javascript" src="http://cdn.zhaopeng.me/vendors/velocity/velocity.min.js"></script>
  <script type="text/javascript" src="http://cdn.zhaopeng.me/vendors/velocity/velocity.ui.min.js"></script>

  <script type="text/javascript" src="http://cdn.zhaopeng.me/js/motion_global.js?v={{ theme.version }}" id="motion.global"></script>

{% else %}

  <script type="text/javascript" src="http://cdn.zhaopeng.me/js/motion_fallback.js?v={{ theme.version }}" id="motion.fallback"></script>

{% endif %}
