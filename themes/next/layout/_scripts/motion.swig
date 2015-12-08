{% if theme.use_motion %}

  <script type="text/javascript" src="http://7xon03.com1.z0.glb.clouddn.com/vendors/velocity/velocity.min.js"></script>
  <script type="text/javascript" src="http://7xon03.com1.z0.glb.clouddn.com/vendors/velocity/velocity.ui.min.js"></script>

  <script type="text/javascript" src="http://7xon03.com1.z0.glb.clouddn.com/js/motion_global.js?v={{ theme.version }}" id="motion.global"></script>

{% else %}

  <script type="text/javascript" src="http://7xon03.com1.z0.glb.clouddn.com/js/motion_fallback.js?v={{ theme.version }}" id="motion.fallback"></script>

{% endif %}
