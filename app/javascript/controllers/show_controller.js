import { Controller } from "@hotwired/stimulus"
import GlobalController from "./global_controller";

// Connects to data-controller="show"
export default class extends GlobalController {
  static targets = ['rightModal', 'postModal']
  connect() {
    if (this.hasRightModalTarget){ this.showRightWrapper() }
    if (this.hasPostModal) { this.showPostWrapper() }
  }

  closeRightModal() {
    super.closeModal("rightModal");
  }

}
