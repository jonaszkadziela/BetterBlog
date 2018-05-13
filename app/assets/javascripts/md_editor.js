function createMdEditor(el = $(".markdown-editor:eq(" + mdEditorId + ")"), type = $(".markdown-editor:eq(" + mdEditorId + ")").data('mdeditor-type'))
{
  mdEditors[mdEditorId] = new SimpleMDE(generateConfig(el, type));
  styleMdEditor(type);
  mdEditorId++;
}

function generateConfig(el, type)
{
  let id = window.location.pathname + "/" + mdEditorId;
  let config =
  {
    element: el[0],
    promptURLs: true,
    spellChecker: false,
    autosave:
    {
      enabled: true,
      uniqueId: id,
      delay: 1000
    },
    shortcuts:
    {
      toggleCodeBlock: "Cmd-Alt-B",
      toggleOrderedList: null,
      toggleUnorderedList: null
    },
    insertTexts: {
      horizontalRule: ["", "-----"],
      table: ["", "| Column 1 | Column 2 | Column 3 |\n| -------- | -------- | -------- |\n| Text     | Text      | Text     |"],
    },
    toolbar: ["heading", "bold", "italic", "strikethrough", "|",
              "unordered-list", "ordered-list", "|", "quote", "code", "horizontal-rule", "|",
              "link", "image", "table", "|", "preview", "guide"]
  }
  switch(type)
  {
    case "post":
    break;

    case "comment":
      config.status = ["autosave"];
    break;
  }
  return config;
}

function styleMdEditor(type)
{
  $("#mde" + mdEditorId + " .CodeMirror, " + "#mde" + mdEditorId + " .CodeMirror-scroll").addClass("md-" + type);
  $("#mde" + mdEditorId + ".CodeMirror").append('<div class="editor-preview markdown"></div>');
}

function clearMdEditors()
{
  mdEditors = new Array();
  mdEditorId = 0;
}