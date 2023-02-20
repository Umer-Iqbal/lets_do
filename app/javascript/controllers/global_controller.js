import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="global"
export default class extends Controller {

  showPostWrapper() {
    document.getElementById('postWrapper').classList.remove('d-none')
  }

  closePostWrapper() {
    this.closeModal('postWrapper')

  }

  showRightWrapper() {
    document.getElementById('rightModal').classList.remove('d-none')
  }

  closeRightWrapper() {
    this.closeModal('rightModal')
  }

  closeModal(modalId) {
    let parentWrapper = document.getElementById(modalId)
    parentWrapper.innerHTML = ''
    parentWrapper.classList.add('d-none')
  }
}
