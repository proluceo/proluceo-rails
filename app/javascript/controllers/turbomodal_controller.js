import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Focus on first input depending on which form is diplayed in the modal
    if (document.getElementById("account_number")) {
      setTimeout(() => {
        document.getElementById("account_number").focus();
      }, 100);
    } else if (document.getElementById("supplier_name")) {
      setTimeout(() => {
        document.getElementById("supplier_name").focus();
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
