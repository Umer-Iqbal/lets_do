import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-polaris-modal"
export default class extends Controller {
  static targets = ["polarisModal"]
  connect() {
    this.showPostFormModal()
  }

  showPostFormModal(){
    let that = this
    this.element.classList.remove('Polaris--hidden')  //show modal

    this.element.querySelector('.Polaris-Modal-CloseButton').addEventListener('click', function (){
      that.element.classList.add('Polaris--hidden') //hide modal
    })
  }
}
