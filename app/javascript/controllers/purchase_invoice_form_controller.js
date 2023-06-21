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
      this.currencyTarget.focus();
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

  focusOnAccount() {
    this.accountTarget.focus();
  }

  focusOnPaidOn() {
    console.log("Focus on paidOn");
    this.paidOnTarget.focus();
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
