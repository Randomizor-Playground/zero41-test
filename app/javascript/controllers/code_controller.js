import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.querySelectorAll("div.highlight pre").forEach((block) => {
      block.classList.add("hljs");
      hljs.highlightElement(block);
    });
  }
}
