import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["button", "content"]

  toggle() {
    this.contentTarget.classList.toggle("hidden")
  }
}
