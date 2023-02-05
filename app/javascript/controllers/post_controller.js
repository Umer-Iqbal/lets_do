import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {

  static targets = ['uploadArea']

  showUpload(){
    this.uploadAreaTarget.classList.remove('d-none')
  }
}
