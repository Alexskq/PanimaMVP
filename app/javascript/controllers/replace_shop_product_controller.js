import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="replace-shop-product"
export default class extends Controller {
  static targets = ["product", "submit1","submit2", "input", "input2"]
  connect() {

  }

  choice(event){
    const old = document.getElementsByClassName("select")
      if (old.length > 0) {
        old[0].classList.remove("select")
      }
    event.currentTarget.classList.add("select") // remplir le formulaire avec la donnée
    this.inputTarget.value = event.currentTarget.dataset.id
    this.input2Target.value = ((event.currentTarget.dataset.price)*1.20)
  }

  submitall(event){

    // this.submit2Target.submit()
  }


}

// Créer les 2 simple form
// leur mettre des datas target
// mettre un data action sur le bouton au click => submit_form()
// mettre une data target sur l'input à completer
// au click sur produit on récupére l'id (event.currentTarget.dataset.id) et on le met dans la valeur de l'input
