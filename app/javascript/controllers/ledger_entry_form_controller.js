import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["account", "debit", "credit", "formSubmit"];

  static values = {
    index: String
  }

  connect() {
    let parts = Array.from(document.querySelectorAll(".ledger-entry-part"));
    const lastLine = parts.pop();

    // Make last line credit or debit field disabled based on the first line
    if (+this.debitTarget.value > 0) {
      this.creditTarget.setAttribute("disabled", true);
      for (const debitInput of this.debitTargets.slice(1)) {
        debitInput.setAttribute("disabled", true);
      }
      lastLine
        .querySelector(`#ledger_entry_parts_${parts.length}__credit_amount`)
        .setAttribute("value", remainingAmount);
      this.checkBalance();
    } else if (+this.creditTarget.value > 0) {
      this.debitTarget.setAttribute("disabled", true);
      for (const creditInput of this.creditTargets.slice(1)) {
        creditInput.setAttribute("disabled", true);
      }
      lastLine
        .querySelector(`#ledger_entry_parts_${parts.length}__debit_amount`)
        .setAttribute("value", remainingAmount);
      this.checkBalance();
    }

    // Focus on last line account select
    lastLine.querySelector("#account_input").focus();

    document.addEventListener("autocomplete.change", (event) => {
      const parentNode = event.target.parentNode;
      console.log(`input[id="${parentNode.id}__debit_amount"]`);
      const debitAmountFieldId = `input[id="${parentNode.id}__debit_amount"]`;
      const creditAmountFieldId = `input[id="${parentNode.id}__credit_amount"]`;
      if (
        parentNode.querySelector(debitAmountFieldId).getAttribute("disabled")
      ) {
        parentNode.querySelector(creditAmountFieldId).focus();
        parentNode.querySelector(creditAmountFieldId).select();
      } else {
        parentNode.querySelector(debitAmountFieldId).focus();
        parentNode.querySelector(debitAmountFieldId).select();
      }
    });
  }

  getAmount() {
    let total = 0;
    let otherParts = 0;

    if (+this.debitTarget.value > 0) {
      total = +this.debitTarget.value;
      for (const creditInput of this.creditTargets) {
        otherParts += +creditInput.value;
      }
    } else {
      total = +this.creditTarget.value;
      for (const debitInput of this.debitTargets) {
        otherParts += +debitInput.value;
      }
    }
    const amounts = { total, otherParts };
    return amounts;
  }

  checkAmount(event) {
    if (this.debitTarget == event.target && event.target.value.length == 0) {
      event.preventDefault();
      this.creditTarget.focus();
    } else if (
      this.creditTarget == event.target &&
      event.target.value.length == 0 &&
      this.creditTarget.value.length == 0
    ) {
      event.preventDefault();
    } else if (this.debitTarget == event.target && +event.target.value > 0) {
      event.preventDefault();
      this.debitTargets[1].setAttribute("disabled", true);
      this.creditTarget.setAttribute("disabled", true);
      this.creditTargets[1].setAttribute("value", this.debitTarget.value);
      this.checkBalance();
      this.accountTargets[1].focus();
    } else if (this.creditTarget == event.target && +event.target.value > 0) {
      event.preventDefault();
      this.creditTargets[1].setAttribute("disabled", true);
      this.debitTarget.setAttribute("disabled", true);
      this.debitTargets[1].setAttribute("value", this.creditTarget.value);
      this.checkBalance();
      this.accountTargets[1].focus();
    }
  }

  checkBalance() {
    const totalAmount = this.getAmount().total;
    const otherPartsAmount = this.getAmount().otherParts;

    let parts = Array.from(document.querySelectorAll(".ledger-entry-part"));

    if (totalAmount === otherPartsAmount) {
      parts.shift();

      for (const part of parts) {
        const submitButton = part.querySelector("input[name='commit']");
        submitButton.style.display = "none";
      }

      this.formSubmitTarget.removeAttribute("disabled");
      this.formSubmitTarget.focus();
    } else {
      const lastPart = parts.pop();
      const submitButton = lastPart.querySelector("input[name='commit']");
      submitButton.style.display = "block";
      this.formSubmitTarget.setAttribute("disabled", true);
    }
  }
}
