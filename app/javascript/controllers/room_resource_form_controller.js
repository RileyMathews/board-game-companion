import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room-resource-form"
export default class extends Controller {
  static targets = ["plus", "minus", "amount"]
  connect() {
    this.plusTarget.value = 0
    this.minusTarget.value = 0
    this.startingAmount = parseInt(this.amountTarget.value)
  }

  plus() {
    this.amountTarget.value++
    this.updateDiffFields()
  }

  minus() {
    this.amountTarget.value--
    this.updateDiffFields()
  }

  amountChanged() {
    this.updateDiffFields()
  }

  plusChanged() {
    if (!this.plusTarget.value) { return }

    this.minusTarget.value = 0
    this.amountTarget.value = this.startingAmount + parseInt(this.plusTarget.value)
    this.updateDiffFields()
  }

  minusChanged() {
    if (!this.minusTarget.value) { return }
    this.plusTarget.value = 0
    this.amountTarget.value = this.startingAmount - parseInt(this.minusTarget.value)
    this.updateDiffFields()
  }

  updateDiffFields() {
    const newValue = parseInt(this.amountTarget.value)
    const diff = newValue - this.startingAmount
    if (diff > 0) {
      this.plusTarget.value = diff
      this.minusTarget.value = 0
    } else {
      this.minusTarget.value = -diff
      this.plusTarget.value = 0
    }
  }
}
