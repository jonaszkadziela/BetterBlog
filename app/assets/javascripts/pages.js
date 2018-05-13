var mdEditors;
var mdEditorId;

$(document).on('turbolinks:load', function() {
  clearMdEditors();

  let selector = $('.markdown-editor');

  for (i = 0; i < selector.length; i++) {
    let element = $('.markdown-editor:eq(' + i + ')');
    let type = element.data('mdeditor-type');
    switch (type) {
      case 'default':
      case 'post':
      case 'comment':
        createMdEditor();
      break;
      default:
        console.log("Invalid data-mdeditor-type value.");
    }
  }
});
