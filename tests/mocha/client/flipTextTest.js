if (!(typeof MochaWeb === 'undefined')){
  MochaWeb.testOnly(function(){
    describe("The text flip function", function(){
      var before = "Hello New Zealand";
      var after = "puɐןɐǝZ ʍǝN oןןǝH";
    
      it("ought to turn '" + before + "' into '" + after + "'.", function() {
        chai.assert.equal(flipText(before), after);
      });
    });
  });
}
