import { Controller } from "@hotwired/stimulus";
import Dropzone from "dropzone";

export default class extends Controller {


  connect() {
    this.dropzone = new Dropzone(this.element, {
      autoQueue: true,
      clickable: true,
      uploadMultiple: false,
      maxFilesize: 10, // MB
    });
  }

  disconnect() {
    this.dropzone.destroy();
  }

  activate(e) {
    // code to activate dropzone overlay
  }

  deactivate(e) {
    // code to deactivate dropzone overlay
  }
}