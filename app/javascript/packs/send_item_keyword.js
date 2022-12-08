const text = document.getElementById("text");
const button = document.getElementById("button");

text.addEventListener('input', function submit(event) {
  button.click();
});
