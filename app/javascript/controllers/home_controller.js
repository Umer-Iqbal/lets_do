import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  connect() {
    this.highLightBtn()
  }

  highLightBtn(){
    let header = document.getElementById('topHeader')
    header.querySelector('#homeBtn').classList.add('active-header-btn')
  }
}
