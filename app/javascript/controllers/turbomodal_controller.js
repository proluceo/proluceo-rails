import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
  }

  close() {
    this.dispatch("close")
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.dispatch("close")
    }
  }
}
