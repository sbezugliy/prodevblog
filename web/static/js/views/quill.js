
export default class QuillEditor{

  constructor(id){
    this.toolbarOptions = [
      ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
      ['blockquote', 'code-block'],

      [{ 'header': 1 }, { 'header': 2 }],               // custom button values
      [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
      [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
      [{ 'direction': 'rtl' }],                         // text direction

      [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
      [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

      [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
      [{ 'font': [] }],
      [{ 'align': [] }],

      ['clean']                                         // remove formatting button
    ];

    this.quill = new Quill(id, {
      modules: {toolbar: this.toolbarOptions},
      theme: 'snow'
    });
  }

  submitter(form_id, field_id){
    var editor_cont = this.quill.getContents();
    $(form_id).submit(function(f) {
      f.preventDefault(); // to stop the form from submitting
      $(field_id).val(JSON.stringify(editor_cont));
      this.submit(); // If all the validations succeeded
    });
  }

}
