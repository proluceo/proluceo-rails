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
        this.currencyTarget.setAttribute("value", event.detail.textValue);
        this.currencyTarget.focus();
        this.currencyTarget.select();
      } else if (
        event.target.id === "currency" &&
        event.target.innerText === "Currency"
      ) {
        this.accountTarget.focus();
        this.accountTarget.select();
      } else if (
        event.target.id === "currency" &&
        event.target.innerText === "Invoices in"
      ) {
        this.currencyTarget.setAttribute("value", event.detail.value);
      } else if (event.target.id === "payment_account") {
        this.paidOnTarget.focus();
      }
    });

    // Event fired when creating a new account or a new supplier
    document.addEventListener("turbo:before-stream-render", (event) => {
      if (event.target.attributes.target.nodeValue === "payment_account") {
        this.paidOnTarget.focus();
      } else if (event.target.attributes.target.nodeValue === "supplier") {
        this.currencyTarget.focus();
        this.currencyTarget.select();
      }
    });
  }

  focusOnSupplier() {
    const issuedOn = this.issuedOnTarget.value;
    if (issuedOn.length === 10 && issuedOn.startsWith("2")) {
      this.supplierTarget.focus();
      this.supplierTarget.select();
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
