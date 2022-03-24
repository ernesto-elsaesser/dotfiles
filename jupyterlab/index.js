import { ICodeMirror } from '@jupyterlab/codemirror';

const vimrc = {
  id: 'vimrc',
  autoStart: true,
  requires: [ICodeMirror],
  activate: function(app, codeMirror) {
    codeMirror.ensureVimKeymap().then(function() {
      codeMirror.CodeMirror.Vim.map('<Space>', ':w', 'normal');
      codeMirror.CodeMirror.Vim.map('ö', '<Esc>', 'insert');
      codeMirror.CodeMirror.Vim.map('ö', '<Esc>', 'visual');
      console.log("vim mappings installed!");
    });
  }
};

export default vimrc;
