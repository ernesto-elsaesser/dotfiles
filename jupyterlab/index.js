import { ICodeMirror } from '@jupyterlab/codemirror';

const vimmap = {
  id: 'mapext',
  autoStart: true,
  requires: [ICodeMirror],
  activate: function(app, codeMirror) {
    codeMirror.ensureVimKeymap().then(function() {
      codeMirror.CodeMirror.Vim.map('ö', '<Esc>', 'insert');
      codeMirror.CodeMirror.Vim.map('ö', '<Esc>', 'visual');
      console.log("vim mappings installed!");
    });
  }
};

export default vimmap;
