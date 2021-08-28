window.addEventListener("trix-file-accept", function (event) {
  const acceptedTypes = ["image/jpeg", "image/png", "image/jpg"];
  if (!acceptedTypes.includes(event.file.type)) {
    event.preventDefault();
    alert("画像ファイル以外は投稿できません");
  }
  const maxFileSize = 1024 * 1024 * 5; // 5MB
  if (event.file.size > maxFileSize) {
    event.preventDefault();
    alert("5MB以上の画像は投稿できません");
  }

  const maxFileCount = 9;
  const fileCount = document.getElementsByTagName("figure").length;
  if (fileCount > maxFileCount) {
    event.preventDefault();
    alert("1回の投稿では10枚が上限です");
  }
});
