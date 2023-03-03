// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { displayLogo } from "./coolbookinganimation"

document.addEventListener("turbo:load", () => {
  displayLogo()
})


// const list = document.querySelector('#search');
// console.log(list);
// list.addEventListener('submit', (event) => {
//   event.preventDefault();
//   const search = event.currentTarget[0].value;
//   list.insertAdjacentHTML("beforeend", `<h1>${search}</h1>`);
// });
