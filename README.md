# fliptext-demo
Demonstrates usage and Velocity testing of the "fliptext" package, which turns "Warehouseman" into "uɐɯǝsnoɥǝɹɐЩ".

Refer to [warehouseman](https://github.com/warehouseman) / [fliptext](https://github.com/warehouseman/fliptext) for more details.

Starting from a "known good base" when trying something new is important so I use this as a kind of disposable test jig for ideas and experiments before incorporating them into bigger projects.  I found Meteorpad a little too restrictive for some of those things.

What fliptext-demo looks like when it's running . . . 
![Velocity with Mocha & Cucumber.](http://i.imgur.com/G0gpavT.png)

### What's this qikRun.sh thing?

I got fed up with Mongo eating a half a Gb for each Meteor demo I tried so  qikRun.sh started out as a two line file :

    export MONGO_URL=mongodb://localhost:27017/fliptext
    meteor

However, I wanted to be able to add/remove some modules easily.  I wanted a single configuration file: settings.json, etc, etc.

If you use Linux with bash you can use qikRun.sh to start Meteor preconfigured by settings.json; both command line settings and runtime settings.

You will need to have ["jq" (the great JSON parser)](http://stedolan.github.io/jq/) installed or somewhere in your PATH.




