<?
  function image_validateFormat() {

    global $FILES;

    if (empty($_FILES)) {
      return false;
    }

    if (!file_exists($_FILES['avatar']['tmp_name'])) {
      return false;
    }

    if (!is_uploaded_file($_FILES['avatar']['tmp_name'])) {
      return false;
    }

    return getimagesize($_FILES["avatar"]["tmp_name"]) !== false;
  }

  function image_writeFile($img, $dst, $ext) {

    if ($ext == 'jpg' || $ext == 'jpeg') {
      return imagejpeg($img, $dst, 90);
    }

    if ($ext == 'gif') {
      return imagegif($img, $dst);
    }

    return imagepng($img, $dst);
  }

  function image_readFile($src, $ext) {

    if ($ext === 'jpg' || $ext === 'jpeg') {
      return imagecreatefromjpeg($src);
    }

    if ($ext === 'png') {
      return imagecreatefrompng($src);
    }

    if ($ext === 'bmp') {
      return imagecreatefromwbmp($src);
    }

    if ($ext === 'gif') {
      return imagecreatefromgif($src);
    }

    return null;
  }

  function image_resize($src, $largest, $ext) {

    $originalWidth = imagesx($src);
    $originalHeight = imagesy($src);

    if ($originalWidth <= 0 || $originalHeight <= 0) {
      return null;
    }

    if ($originalHeight > $originalWidth && $originalHeight > $largest) {
      $newHeight = $largest;
      $newWidth = $newHeight * ($originalWidth / $originalHeight);
    }
    else if($originalWidth > $originalHeight && $originalWidth > $largest) {
      $newWidth = $largest;
      $newHeight = $newWidth * ($originalHeight / $originalWidth);
    }
    else {
      $newWidth = $originalWidth;
      $newHeight = $originalHeight;
    }

    $thumbnailImage = imagecreatetruecolor($newWidth, $newHeight);

    if ($thumbnailImage == null) {
      return null;
    }

    if ($ext == 'gif' || $ext == 'png') {
      imagecolortransparent($thumbnailImage, imagecolorallocatealpha($thumbnailImage, 0, 0, 0, 127));
      imagealphablending($thumbnailImage, false);
      imagesavealpha($thumbnailImage, true);
    }

    if (imagecopyresampled($thumbnailImage, $src, 0, 0, 0, 0, $newWidth, $newHeight, $originalWidth, $originalHeight)) {
      return $thumbnailImage;
    }

    return null;
  }

  function image_crop($src, $largest, $ext) {

    $originalWidth = imagesx($src);
    $originalHeight = imagesy($src);

    if ($originalWidth <= 0 || $originalHeight <= 0) {
      return null;
    }

    $operationResult = false;
    $thumbnailImage = imagecreatetruecolor($largest, $largest);

    if ($thumbnailImage == null) {
      return null;
    }

    if ($ext == 'gif' || $ext == 'png') {
      imagecolortransparent($thumbnailImage, imagecolorallocatealpha($thumbnailImage, 0, 0, 0, 127));
      imagealphablending($thumbnailImage, false);
      imagesavealpha($thumbnailImage, true);
    }

    if ($originalHeight == $originalWidth) {
      $operationResult = imagecopyresampled($thumbnailImage, $src, 0, 0, 0, 0,
        $largest, $largest, $originalWidth, $originalHeight);
    }
    else if ($originalWidth > $originalHeight) {
      $difference = $originalWidth - $originalHeight;
      $operationResult = imagecopyresampled($thumbnailImage, $src, 0, 0, $difference / 2, 0,
        $largest, $largest, $originalHeight, $originalHeight);
    }
    else {
      $difference = $originalHeight - $originalWidth;
      $operationResult = imagecopyresampled($thumbnailImage, $src, 0, 0, 0, $difference / 2,
        $largest, $largest, $originalWidth, $originalWidth);
    }

    return $operationResult ? $thumbnailImage : null;
  }

  function image_advancedcrop($src, $targetWidth, $targetHeight, $ext) {

    $originalWidth = imagesx($src);
    $originalHeight = imagesy($src);

    if ($originalWidth <= 0 || $originalHeight <= 0) {
      return null;
    }

    $originalAspect = $originalWidth / $originalHeight;
    $thumbnailAspect = $targetWidth / $targetHeight;
    $thumbnailImage = imagecreatetruecolor($targetWidth, $targetHeight);

    if ($thumbnailImage == null) {
      return null;
    }

    if ($ext == 'gif' || $ext == 'png') {
      imagecolortransparent($thumbnailImage, imagecolorallocatealpha($thumbnailImage, 0, 0, 0, 127));
      imagealphablending($thumbnailImage, false);
      imagesavealpha($thumbnailImage, true);
    }

    if ($originalAspect >= $thumbnailAspect) {
      $newHeight = $targetHeight;
      $newWidth = $originalWidth / ($originalHeight / $targetHeight);
    }
    else {
      $newWidth = $targetWidth;
      $newHeight = $originalHeight / ($originalWidth / $targetWidth);
    }

    $operationResult = imagecopyresampled($thumbnailImage,
       $src,
       0 - ($newWidth - $targetWidth) / 2,
       0 - ($newHeight - $targetHeight) / 2,
       0,
       0,
       $newWidth, $newHeight, $originalWidth, $originalHeight);

    return $operationResult ? $thumbnailImage : null;
  }
?>