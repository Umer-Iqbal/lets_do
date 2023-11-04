import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = ['searchField']

  static values = {
     searchUrl: String,
  }

  removeText(ev){
    this.searchFieldTarget.value = ''
    this.sendRequest()
  }

  sendRequest(){
    get(this.searchUrlValue, {
      query: {
        query: this.searchFieldTarget.value,
      },
      responseKind: "turbo-stream"
    });
  }
}
