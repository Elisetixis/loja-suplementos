const slides = [
  "img/promo1.jpg",
  "img/promo2.jpg",
  "img/promo3.jpg",
  "img/promo4.jpg",
  "img/promo5.jpg"
];

let index = 0;

function trocarSlide(i) {
  index = i;
  document.getElementById("slide").src = slides[index];
}

setInterval(() => {
  index++;
  if (index >= slides.length) index = 0;

  document.getElementById("slide").src = slides[index];
}, 3000);