CKEDITOR.editorConfig = function(config) {
  config.language = 'en';
  config.width = '908';
  config.height = '800';
  config.enterMode = CKEDITOR.ENTER_BR;
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";


  CKEDITOR.stylesSet.add( 'my_styles', [
      // Block-level styles
      { name: 'Double Space', element: 'p', styles: { 'line-height': '2.0' } },
      { name: 'Red Title' , element: 'h3', styles: { 'color': 'Red' } },

      // Inline styles
      { name: 'Marker: Yellow', element: 'span', styles: { 'background-color': 'Yellow' } }
  ] );

  config.stylesSet = 'my_styles';
  config.toolbar_Pure = [
    '/', {
      name: 'basicstyles',
      items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
    }, {
      name: 'paragraph',
      items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
    }, {
      name: 'links',
      items: ['Link', 'Unlink']
    }, '/', {
      name: 'styles',
      items: ['Styles', 'Format', 'Font', 'FontSize']
    }, {
      name: 'colors',
      items: ['TextColor', 'BGColor']
    }, {
      name: 'insert',
      items: ['Image', 'Table', 'HorizontalRule', 'PageBreak']
    }
  ];
  config.toolbar = 'Pure';

  return true;

}