import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-create"
export default class extends Controller {
  connect() {
    this.global.showPostWrapper()
  }

  get global() {
    return this.application.controllers.find(controller => {
      return controller.context.identifier === 'global'
    })
  }
}
