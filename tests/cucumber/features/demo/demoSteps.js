
(function () {

  'use strict';

  module.exports = function () {

    var helper = this;

    this.Given(/^I am on the home page$/, function (next) {
      console.log("On home page?");
      var world = helper.world;
      world.browser.
        url(world.cucumber.mirror.rootUrl).
        call(next);
      console.log("yes");
    });

    this.When(/^I see "([^"]*)" in the field "([^"]*)"$/, function (soughtText, field, next) {
      console.log("%s contains %s", field, soughtText);
      var elem = '.' + field;
      helper.world.browser.waitForExist(elem, 7000).waitForVisible(elem)
        .getText(elem, function (err, foundText) {
          console.log("callback gets " + foundText + " from " + field);
          if (foundText === soughtText) {
            next();
          } else {
            next.fail('Found :: ' + foundText);
          }
        });
    });

    this.Then(/^I should see "([^"]*)" the field "([^"]*)"\.$/, function (soughtText, field, next) {
      console.log("%s contains %s", field, soughtText);
      var elem = '.' + field;
      helper.world.browser.waitForExist(elem, 7000).waitForVisible(elem)
        .getText(elem, function (err, foundText) {
          console.log("callback gets " + foundText + " from " + field);
          if (foundText === soughtText) {
            next();
          } else {
            next.fail('Found :: ' + foundText);
          }
        });
    });

  };

})();