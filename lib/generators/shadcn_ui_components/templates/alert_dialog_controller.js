import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert-dialog"
export default class extends Controller {
  static targets = ["content"]
  static values = {
    open: {
      type: Boolean,
      default: false
    }
  }

  open(e) {
    console.log(this.contentTarget.innerHTML)
    document.body.insertAdjacentHTML('beforeend', this.contentTarget.innerHTML)
  }
}