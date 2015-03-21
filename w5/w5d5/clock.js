var myBind = require('./bind.js');

function Clock () {

}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  console.log('The time now is: ' + this.currentTime.getHours() + ':' +
                                    this.currentTime.getMinutes() + ':' +
                                    this.currentTime.getSeconds());
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.currentTime = new Date();
  this.printTime();
  setInterval(this._tick.myBind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  var time = this.currentTime;
  time.setSeconds(time.getSeconds() + Clock.TICK / 1000);
  this.printTime();
};

var clock = new Clock();
clock.run();
