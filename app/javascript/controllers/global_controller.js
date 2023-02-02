import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="global"
export default class extends Controller {

  showPostWrapper() {
    document.getElementById('postWrapper').classList.remove('d-none')
  }

  closePostWrapper() {
    let parentWrapper = document.getElementById('postWrapper')
    parentWrapper.innerHTML = ''
    parentWrapper.classList.add('d-none')
  }
}
