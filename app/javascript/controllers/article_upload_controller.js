import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "fileNamesContainer", "staffContainer"];

  connect() {
    this.inputTarget.addEventListener('change', this.handleFileChange.bind(this));
  }

  disconnect() {
    this.inputTarget.removeEventListener('change', this.handleFileChange.bind(this));
  }

  handleFileChange(event) {
    const files = event.target.files;
    this.staffContainerTarget.style.display = 'block';
    this.fileNamesContainerTarget.innerHTML = ''; // Clear previous inputs

    Array.from(files).forEach((file, index) => {
      const input = document.createElement('input');
      input.type = 'text';
      input.name = `file_names[${index}]`;

      let nameWithoutExtension = file.name.replace(/\.[^/.]+$/, "");
      let humanizedName = nameWithoutExtension.replace(/[_-]/g, ' ')
        .split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');

      input.value = humanizedName;

      const label = document.createElement('label');
      label.textContent = `Name for ${file.name}: `;
      label.appendChild(input);

      this.fileNamesContainerTarget.appendChild(label);
      this.fileNamesContainerTarget.appendChild(document.createElement('br')); // Line break for readability
    });
  }
}

