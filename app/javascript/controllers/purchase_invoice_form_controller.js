import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "issuedOn",
    "paidOn",
    "supplier",
    "currency",
    "account",
    "reference",
  ];

  connect() {
    this.issuedOnTarget.focus();

    // Event fired by stimulus-autocomplete: https://github.com/afcapel/stimulus-autocomplete
    document.addEventListener("autocomplete.change", (event) => {
      if (event.target.id === "supplier") {
        this.currencyTarget.focus();
      } else if (event.target.id === "currency") {
        this.accountTarget.focus();
      } else if (event.target.id === "payment_account") {
        this.paidOnTarget.focus();
      }
    });

    // Event fired when creating a new account
    document.addEventListener("turbo:before-stream-render", () => {
      this.paidOnTarget.focus();
    });
  }

  focusOnSupplier() {
    const issuedOn = this.issuedOnTarget.value;
    if (issuedOn.length === 10 && issuedOn.startsWith("2")) {
      this.supplierTarget.focus();
    }
  }

  prefillPaidOn() {
    this.paidOnTarget.setAttribute("value", this.issuedOnTarget.value);
  }

  focusOnReference(e) {
    e.preventDefault();
    const paidOn = this.paidOnTarget.value;
    if (paidOn.length === 10 && paidOn.startsWith("2")) {
      this.referenceTarget.focus();
    }
  }
}
