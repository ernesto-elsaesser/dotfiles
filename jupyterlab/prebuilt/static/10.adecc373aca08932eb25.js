"use strict";(self.webpackChunkvimrc=self.webpackChunkvimrc||[]).push([[10],{10:(r,i,e)=>{e.r(i),e.d(i,{default:()=>a});const a = {
    id: "vimrc",
    autoStart: true,
    requires: [e(768).ICodeMirror],
    activate: function(r,i) {
        i.ensureVimKeymap().then((function() {
            const api = i.CodeMirror.Vim;
            api.map("<Space>",":w","normal");
            const wrapped = api.findKey;
            api.findKey = function(cm, key, origin) { if (key == "ö") key = '<Esc>'; return wrapped(cm, key, origin); };
            console.log('vim patched');
        }))
    }
}}}]);