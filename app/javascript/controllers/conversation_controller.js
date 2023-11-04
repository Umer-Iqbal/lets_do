import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conversation"
export default class extends Controller {
  connect() {
    this.highLightBtn()
  }

  highLightBtn(){
    let header = document.getElementById('topHeader')
    header.querySelector('#conversationBtn').classList.add('active-header-btn')
  }
}
