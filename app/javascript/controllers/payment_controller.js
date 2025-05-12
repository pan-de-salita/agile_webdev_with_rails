import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="payment"
export default class extends Controller {
  connect() {}

  static targets = ["selection", "additionalFields"];

  initialize() {
    this.showAdditionalFields();
  }

  showAdditionalFields() {
    let selection = this.selectionTarget.value;

    for (let field of this.additionalFieldsTargets) {
      field.disabled = field.hidden = field.dataset.type != selection;
    }
  }
}
