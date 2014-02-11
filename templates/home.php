<?php include('header.php') ?>
<section class="row">
  <div class="col-md-12">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>ID</th>
          <th>Nom de l'item en stock</th>
          <th>Quantité</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach($AEdata as $UUID => $stock) : ?>
          <tr class="">
            <td>
              <?php $item = $getID($UUID); echo  $item['id'].':'.$item['meta']; ?>
            </td>
            <td>
              <?php if(isset($IDMap[$item['id']])) echo $IDMap[$item['id']] ; ?>
            </td>
            <td>
              <?php echo $stock ; ?>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</section>
<?php include('footer.php') ?>

