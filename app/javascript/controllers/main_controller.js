import {Controller} from "@hotwired/stimulus"
import GlobalController from "./global_controller";

// Connects to data-controller="main"
export default class extends GlobalController {

  static get targets() {
    return ["close"]
  }

  closeCreate() {
    this.closePostWrapper()
  }

}
