<?
  include('templates/header_background.php');
?>
<div class="ink-grid overlay top-padding bottom-padding push-center xlarge-50 large-60 medium-80 all-100">
  <div class="double-horizontal-padding">
    <img src="img/header.png" alt="">
  </div>
  <div class="align-center half-top-padding double-bottom-padding">
    <h1 class="slab">Página não encontrada</h1>
    <p>Pedimos desculpa, mas a página que tentou visualizar não existe.</p>
    <form class="ink-form medium half-top-padding" action="#" method="get">
      <div class="control-group all-15">
      </div>
      <div class="control-group all-70">
        <div class="control append-button" role="search">
          <span>
            <input type="text" name="name" id="name">
          </span>
          <button class="ink-button black">Pesquisar</button>
        </div>
      </div>
    </form>
  </div>
</div>
<?
  include('templates/footer_empty.php');
?>