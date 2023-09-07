import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="video"
export default class extends Controller {
  static targets = ["video"]
  connect() {
    const video = document.querySelector("video")
    console.log(this.videoTarget);
    this.videoTarget.loop = true;
    this.videoTarget.play();
  }
}
