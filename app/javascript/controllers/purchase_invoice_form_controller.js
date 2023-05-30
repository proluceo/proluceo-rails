import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["issuedOn", "paidOn"];

  connect() {}

  focusOnSupplier() {
    const issuedOn = this.issuedOnTarget.value;
    if (issuedOn.length === 10 && issuedOn.startsWith("2")) {
      document.getElementById("supplier").focus();
    }
  }

  prefillPaidOn() {
    document
      .getElementById("paidOn")
      .setAttribute("value", this.issuedOnTarget.value);
  }

  focusOnReference(e) {
    e.preventDefault();
    const paidOn = this.paidOnTarget.value;
    if (paidOn.length === 10 && paidOn.startsWith("2")) {
      document.getElementById("reference").focus();
    }
  }
}
