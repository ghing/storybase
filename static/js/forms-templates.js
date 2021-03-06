/** 
 * Include this template file after backbone-forms.amd.js to override the default templates
 * 
 * 'data-*' attributes control where elements are placed
 */
;(function(Form) {

    
  /**
   * Templates to match those used previous versions of Backbone Form, i.e. <= 0.11.0.
   * NOTE: These templates are deprecated.
   * NOTE: This version is hacked from the distribution old.js to remove 
   * references to Form.editors.List as that editor no longer appears to be
   * supported.
   */
  Form.template = _.template('\
    <form class="bbf-form" data-fieldsets></form>\
  ');


  Form.Fieldset.template = _.template('\
    <fieldset>\
      <% if (legend) { %>\
        <legend><%= legend %></legend>\
      <% } %>\
      <ul data-fields></ul>\
    </fieldset>\
  ');


  Form.Field.template = _.template('\
    <li class="bbf-field field-<%= key %>">\
      <label for="<%= editorId %>"><%= title %></label>\
      <div class="bbf-editor" data-editor></div>\
      <div class="bbf-help"><%= help %></div>\
      <div class="bbf-error" data-error></div>\
    </li>\
  ');

  Form.NestedField.template = _.template('\
    <li class="bbf-field bbf-nested-field field-<%= key %>">\
      <label for="<%= editorId %>"><%= title %></label>\
      <div class="bbf-editor" data-editor></div>\
      <div class="bbf-help"><%= help %></div>\
      <div class="bbf-error" data-error></div>\
    </li>\
  ');


  Form.editors.Date.template = _.template('\
    <div class="bbf-date">\
      <select class="bbf-date" data-type="date"><%= dates %></select>\
      <select class="bbf-month" data-type="month"><%= months %></select>\
      <select class="bbf-year" data-type="year"><%= years %></select>\
    </div>\
  ');


  Form.editors.DateTime.template = _.template('\
    <div class="bbf-datetime">\
      <div class="bbf-date-container" data-date></div>\
      <select data-type="hour"><%= hours %></select>\
      :\
      <select data-type="min"><%= mins %></select>\
    </div>\
  ');

})(Backbone.Form);
