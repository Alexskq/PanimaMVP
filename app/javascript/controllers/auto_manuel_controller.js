import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-manuel"
export default class extends Controller {
  static targets = ["remove", "remove2", "remove3", "remove4", "remove5", "button"]
  connect() {

    console.log(document.cookie);
    if (document.cookie.includes('auto=false') ) {
      this.buttonTarget.checked = true
      this.removeelement()
    }

  }


  removeelement(){

    if ( this.buttonTarget.checked ) {
      document.cookie = 'auto=false'
    } else {
      document.cookie = 'auto=true'
    }
      this.removeTarget.classList.toggle("d-none")
      this.remove2Targets.forEach(element => {
        element.classList.toggle("d-none")
      });
      this.remove3Target.classList.toggle("d-none")
      this.remove4Target.classList.toggle("d-none")
      this.remove5Targets.forEach(element => {
        element.classList.toggle("d-none")
      });

  }




}
