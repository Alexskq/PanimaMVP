import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-products-modal"
export default class extends Controller {
  static targets = ["form", "input", "list"]
  connect() {

  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
  fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      console.log(data)
     console.log("Products before : ", this.listTarget);
      this.listTarget.innerHTML = data
     console.log("Product NOW : ",this.listTarget);

    })
  }
}
