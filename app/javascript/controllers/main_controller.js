import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="main"
export default class extends Controller {

  static get targets() {
    return ["close"]
  }

  closeCreate() {
    this.global.closePostWrapper()
  }


  get global() {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === 'global'
    })
  }
}
