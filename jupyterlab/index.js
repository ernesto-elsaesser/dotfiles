import { ICodeMirror } from '@jupyterlab/codemirror';

const vimrc = {
  id: 'vimrc',
  autoStart: true,
  requires: [ICodeMirror],
  activate: function(app, codeMirror) {
    codeMirror.ensureVimKeymap().then(function() {
      console.log("DUMMY"); // actual code in prebuilt
    });
  }
};

export default vimrc;
