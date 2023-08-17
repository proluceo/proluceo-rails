import NestedForm from "stimulus-rails-nested-form";

export default class extends NestedForm {
  static targets = [...super.targets, "contactFirstName"];

  connect() {
    super.connect();
  }

  add(t) {
    super.add(t);
    const lastFirstNameInput = this.contactFirstNameTargets.pop();
    lastFirstNameInput.focus();
  }
}
