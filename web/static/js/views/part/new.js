import MainView from '../main';
import QuillEditor from '../quill';

export default class PartNewView extends MainView {
  mount() {
    super.mount();

    let quill = new QuillEditor('#editor');
    quill.submitter("#part_form", "#part_content");
    // Specific logic here
    console.log('PartNewView mounted');
  }

  unmount() {
    super.unmount();

    // Specific logic here
    console.log('PartNewView unmounted');
  }
}
