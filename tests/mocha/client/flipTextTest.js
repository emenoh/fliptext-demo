if (!(typeof MochaWeb === 'undefined')){
  MochaWeb.testOnly(function(){
    describe("The text flip function", function(){
      var before = "Hello Tasmania";
      var after = "ɐıuɐɯsɐ┴ oןןǝH";
    
      it("should turn '" + before + "' into '" + after + "'", function() {
        chai.assert.equal(flipText(before), after);
      });
    });
  });
}
