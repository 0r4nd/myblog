import { useState } from "react";

import hljs from 'highlight.js';
import ReactQuill, { Quill } from "react-quill";
import quillEmoji from "quill-emoji";
import ImageResize from "quill-image-resize-module-react";

import 'react-quill/dist/quill.snow.css';
import 'highlight.js/styles/atom-one-light.css';
//import 'highlight.js/styles/atom-one-dark.css';
import "quill-emoji/dist/quill-emoji.css";



Quill.register('modules/imageResize', ImageResize);
Quill.register({
  'formats/emoji': quillEmoji.EmojiBlot,
  'modules/emoji-shortname': quillEmoji.ShortNameEmoji,
  'modules/emoji-toolbar': quillEmoji.ToolbarEmoji,
  'modules/emoji-textarea': quillEmoji.TextAreaEmoji
}, true);

hljs.configure({
  languages: ['javascript', 'python'],
});

const modules = {
  syntax: {
    highlight: text => hljs.highlightAuto(text).value
  },
  imageResize: {
    parchment: Quill.import('parchment'),
    modules: ['Resize', 'DisplaySize', 'Toolbar']
  },
  toolbar: [
    [{ 'header': [1, 2, 3, false] }],
    ['bold', 'italic', 'underline', 'strike'],
    ['blockquote','code-block'],
    [{'list': 'ordered'}, {'list': 'bullet'}],
    [{ 'color': [] }, { 'background': [] }],
    ['link', 'image', 'video'],
    ['clean'],
  ],
  clipboard: {
    matchVisual: false,
  },
  "emoji-toolbar": true,
  "emoji-textarea": true,
  "emoji-shortname": true,
};

const formats = [
  'header',
  'font',
  'size',
  'bold',
  'italic',
  'underline',
  'strike',
  'blockquote',
  'list',
  'bullet',
  'indent',
  'link',
  'image',
  'video',
  'color',
  'background',
  'code-block',
  'emoji',
];

export default function CreatePost() {
  const [title,setTitle] = useState('');
  const [summary,setSummary] = useState('');
  const [content,setContent] = useState('');
  const [files, setFiles] = useState('');

  async function createNewPost(ev) {
    const data = new FormData();
    data.set('title', title);
    data.set('summary', summary);
    data.set('content', content);
    data.set('file', files[0]);
    ev.preventDefault();
    const response = await fetch('http://localhost:8000/post', {
      method: 'POST',
      body: data,
    });
  }

  return (
    <div className="create-page">
      <form onSubmit={createNewPost}>
        <input type="title"
              placeholder="Title"
              value={title}
              onChange={ev => setTitle(ev.target.value)}/>
        <input type="summary"
              placeholder="Summary"
              value={summary}
              onChange={ev => setSummary(ev.target.value)}/>
        <input type="file"
              onChange={ev => setFiles(ev.target.files)}/>
        <ReactQuill modules={modules}
                    formats={formats}
                    value={content}
                    onChange={newValue => setContent(newValue)}/>
        <button style={{marginTop:'5px'}}>Create</button>

        <details>
          <summary>Output</summary>
          <div className="html-result">{content}</div>
        </details>

        <div className="content" style={{border:'2px solid black'}}>
          <div className='ql-snow'>
            <div className="ql-editor" dangerouslySetInnerHTML={{__html: content}}></div>
          </div>
        </div>

      </form>
    </div>
  )
}
