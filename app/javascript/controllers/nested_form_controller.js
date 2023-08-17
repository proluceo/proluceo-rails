import NestedForm from "stimulus-rails-nested-form";

export default class extends NestedForm {
  static targets = [...super.targets, "firstNestedInput"];

  connect() {
    super.connect();
  }

  add(t) {
    super.add(t);
    const lastLineFirstInput = this.firstNestedInputTargets.pop();
    lastLineFirstInput.focus();
  }
}
