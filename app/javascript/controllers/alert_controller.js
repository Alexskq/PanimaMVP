import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {

  static values = {
    icon: String,
    alertTitle: String,
    alertHtml: String,
    confirmButtonText: String,
    showCancelButton: Boolean,
    cancelButtonText: String
  }

    connect(){

    }
  initSweetalert(event) {
    // console.log("connect");
    event.preventDefault(); // Prevent the form to be submited after the submit button has been clicked

    Swal.fire({
      icon: 'success',
      title: 'Changement terminé',
      showConfirmButton: false,
      timer: 1500
    }).then((action) => {
      this.element.submit();
    })

  }
}
