import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    if (document.getElementById("account_number")) {
      setTimeout(() => {
        document.getElementById("account_number").focus();
      }, 100);
    }
  }

  close() {
    this.dispatch("close");
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.dispatch("close");
    }
  }
}
