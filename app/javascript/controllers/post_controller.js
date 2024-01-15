import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {

  static targets = ['uploadArea', 'postFormModal']

  showUpload(ev){
    ev.currentTarget.innerText = this.uploadAreaTarget.classList.contains('d-none') ? "Hide Upload" : "Upload"
    this.uploadAreaTarget.classList.toggle('d-none')
  }

  connect() {
    this.showPostFormModal()
  }

  showPostFormModal(){
    this.postFormModalTarget.classList.remove('Polaris--hidden')
  }

  hidePostFormModal(){
    this.postFormModalTarget.classList.add('Polaris--hidden')
  }
}
