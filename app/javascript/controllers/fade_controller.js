import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fade"
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}
