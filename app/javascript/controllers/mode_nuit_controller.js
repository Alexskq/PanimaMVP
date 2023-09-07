import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mode-nuit"
export default class extends Controller {
  static targets = ["button", "nuit"]
  connect() {
  }

  toggleDarkMode(event) {
    console.log(event.currentTarget.checked)
    fetch("/profils/theme")
    document.querySelector("body").classList.toggle("dark");
  }

}
