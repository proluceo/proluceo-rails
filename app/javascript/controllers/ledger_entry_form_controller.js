import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["position", "account", "debit", "credit", "formSubmit"];

  connect() {
    // Remove New Line button from every line except the last one.
    let parts = Array.from(document.querySelectorAll(".ledger-entry-part"));
    const lastLine = parts.pop();

    for (const part of parts) {
      const submitButton = part.querySelector("input[name='commit']");
      submitButton.style.display = "none";
    }

    // Set new line date to first line date
    lastLine
      .querySelector("input[type='date']")
      .setAttribute("value", this.positionTarget.value);

    // Make last line credit or debit field disabled based on the first line
    if (+this.debitTarget.value > 0) {
      this.creditTarget.setAttribute("disabled", true);
      for (const debitInput of this.debitTargets.slice(1)) {
        debitInput.setAttribute("disabled", true);
      }
    } else if (+this.creditTarget.value > 0) {
      this.debitTarget.setAttribute("disabled", true);
      for (const creditInput of this.creditTargets.slice(1)) {
        creditInput.setAttribute("disabled", true);
      }
    }

    // Focus on first line date or last line account select
    if (
      this.positionTarget.value.length === 10 &&
      this.positionTarget.value.startsWith("2")
    ) {
      lastLine.querySelector("select").focus();
    } else {
      this.positionTarget.focus();
    }

    this.formSubmitTarget.setAttribute("disabled", true);
  }

  checkDate() {
    // Once first line date is filled in, set second line date and focus on first line account select
    if (
      this.positionTarget.value.length === 10 &&
      this.positionTarget.value.startsWith("2")
    ) {
      this.accountTarget.focus();
      this.positionTargets[1].setAttribute("value", this.positionTarget.value);
    }
  }

  focusOnAmountField(event) {
    const parentNode = event.target.parentNode;
    const debitAmountFieldId = `input[id="${parentNode.id}__debit_amount"]`;
    const creditAmountFieldId = `input[id="${parentNode.id}__credit_amount"]`;
    if (parentNode.querySelector(debitAmountFieldId).getAttribute("disabled")) {
      parentNode.querySelector(creditAmountFieldId).focus();
    } else {
      parentNode.querySelector(debitAmountFieldId).focus();
    }
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
      this.accountTargets[1].focus();
      this.debitTargets[1].setAttribute("disabled", true);
      this.creditTarget.setAttribute("disabled", true);
    } else if (this.creditTarget == event.target && +event.target.value > 0) {
      event.preventDefault();
      this.accountTargets[1].focus();
      this.creditTargets[1].setAttribute("disabled", true);
      this.debitTarget.setAttribute("disabled", true);
    }
  }

  checkTotalAmount() {
    const totalAmount =
      +this.debitTarget.value > 0
        ? +this.debitTarget.value
        : +this.creditTarget.value;
    let otherPartsAmount = 0;

    if (+this.debitTarget.value > 0) {
      for (const creditInput of this.creditTargets) {
        otherPartsAmount += +creditInput.value;
      }
    } else {
      for (const debitInput of this.debitTargets) {
        otherPartsAmount += +debitInput.value;
      }
    }

    if (totalAmount === otherPartsAmount) {
      let parts = Array.from(document.querySelectorAll(".ledger-entry-part"));
      parts.shift();

      for (const part of parts) {
        const submitButton = part.querySelector("input[name='commit']");
        submitButton.style.display = "none";
      }

      this.formSubmitTarget.removeAttribute("disabled");
      this.formSubmitTarget.focus();
    }
  }
}
