if (Meteor.isClient) {

  Template.fliptext.rendered = function () {
    console.log("~~~~ Fliptext demo -- client-side template rendered ~~~");
    $(".flippant").flipElementText();
  };

}
