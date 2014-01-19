/**
 * Dialog attach Marionette Region
 * 
 *
 */
Marionette.Region.Dialog = Marionette.Region.extend({
  onShow: function(view){
    this.listenTo(view, "dialog:close", this.closeDialog);

    var self = this;
    this.$el.dialog({
      modal: true,
      title: view.title,
      close: function(e, ui){
        self.closeDialog();
      }
    });
  },

  closeDialog: function(){
    this.stopListening();
    this.close();
    this.$el.dialog("destroy");
  }
});