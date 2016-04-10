<script>
  $(function() {
    $("ul#footer-links").hide();
    $("#footer").hover(function() {
      $("ul#footer-links").stop(!0, !0).slideToggle("fast");
    })
  });
</script>
<footer id="footer" class="clearfix medium fixed">
  <div class="ink-grid">
    <ul id="footer-links" class="unstyled medium inline quarter-vertical-space">
      <li><a href="about.php">About</a></li>
      <li><a href="sitemap.php">Sitemap</a></li>
      <li><a href="contacts.php">Contacts</a></li>
    </ul>
    <p class="note medium no-margin half-vertical-padding">
       <i class="fa fa-copyright"></i>
       2016 KnowUp! - Collaborative Q&A
    </p>
  </div>
</footer>
</body>
</html>