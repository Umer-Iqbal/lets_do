import {Controller} from "@hotwired/stimulus"
import GlobalController from "./global_controller";

// Connects to data-controller="main"
export default class extends GlobalController {

  static get targets() {
    return ["close"]
  }

  connect() {
    document.addEventListener('click', this.closeAllDropDowns)
  }

  closeCreate() {
    this.closePostWrapper()
  }

  closeAllDropDowns(){
    Array.from(document.getElementsByClassName('close-dropdown')).forEach(function (dropdown){
      if(dropdown.firstElementChild != null){
        dropdown.firstElementChild.remove()
      }
    })

  }

}
