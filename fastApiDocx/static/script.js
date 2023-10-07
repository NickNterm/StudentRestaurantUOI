$(document).ready(function () {
  $("input[type=file]").click(function () {
    $(this).val("");
  });

  $("input[type=file]").change(function () {
    document.getElementById("inputResult").innerHTML = this.files[0].name;
    document.getElementById("inputButton").innerHTML = "Change";
    document.getElementById("continueButton").style.display = "block";
  });

  $("#continueButton").click(function () {});
});
