import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["account", "amount", "submit"];

  connect() {
    if (this.accountTarget) {
      this.accountTarget.focus();
    }

    // Event fired when creating a new account
    document.addEventListener("turbo:before-stream-render", (event) => {
      const node = event.detail.newStream.attributes[1].nodeValue;
      if (node === "new_purchase_invoice_line_account_number") {
        this.amountTarget.focus();
        this.amountTarget.select();
      } else {
        this.submitTarget.focus();
      }
    });
  }

  focusOnAmount() {
    this.amountTarget.focus();
    this.amountTarget.select();
  }
}
