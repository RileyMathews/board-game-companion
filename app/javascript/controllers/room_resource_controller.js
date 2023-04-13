import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room-resource"
export default class extends Controller {
  static targets = ["output", "id"]

  increment() {
    this.current = this.current + 1
  }

  decrement() {
    this.current = this.current - 1
  }

  get current() {
    return parseInt(this.outputTarget.textContent)
  }

  get id() {
    return this.idTarget.id
  }

  set current(next) {
    this.outputTarget.textContent = next
    fetch(`${location.origin}/room_resources/${this.id}`, {
      method: "PATCH",
      body: JSON.stringify({ "ammount": next }),
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
    });
  }
}
