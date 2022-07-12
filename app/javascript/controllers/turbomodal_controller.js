import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
  }

  close() {
    this.dispatch("close")
  }

  submitEnd(e) {
    console.log(e)
    if (e.detail.success) {
      console.log("Closed!")
      this.dispatch("close")
    }
  }
}
