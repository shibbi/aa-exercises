function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

function Course(name, department, credits, days, block) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.block = block;
}

var tripp = new Student("Tripp", "Davis");
var shibo = new Student("Shibo", "Fang");

var ruby = new Course("Ruby", "CS", 10, ['mon', 'tue', 'fri'], 4);
var javascript = new Course("JavaScript", "CS", 15, ['mon', 'wed', 'fri'], 5);
var chemistry = new Course("Chemistry", "Science", 8, ['wed', 'fri'], 4);
var biology = new Course("Biology", "Science", 12, ['tue', 'thu'], 7);
var physics = new Course("Physics", "Science", 7, ['tue', 'thu'], 5);

Student.prototype.name = function() {
  return this.firstName + " " + this.lastName;
};

// console.log(tripp.name());

Course.prototype.conflictsWith = function(anotherCourse) {
  if (this.block === anotherCourse.block) {
    for (var i = 0; i < this.days.length; i++) {
      if (anotherCourse.days.indexOf(this.days[i]) > -1) {
        return true;
      }
    }
  }
  return false;
};

// console.log(ruby.conflictsWith(chemistry)); // true
// console.log(ruby.conflictsWith(javascript)); // false
// console.log(physics.conflictsWith(javascript)); // false

Student.prototype.enroll = function(course) {
  for (var i = 0; i < this.courses.length; i++) {
    if (this.courses[i].conflictsWith(course)) {
      throw("ERROR ERROR, SYSTEM CAN'T PROCESS");
    }
  }
  course.students.push(this);
  this.courses.push(course);
};

shibo.enroll(ruby);
shibo.enroll(javascript);
// try {
//   shibo.enroll(chemistry);
// } catch(err) {
//   console.log(err);
// }
// console.log(shibo.courses);
// console.log(shibo.courses[0].students);

Student.prototype.courseLoad = function() {
  var load = {};
  for (var i = 0; i < this.courses.length; i++) {
    var dept = this.courses[i].department;
    var creds = this.courses[i].credits;
    if (!load[dept]) {
      load[dept] = creds;
    } else {
      load[dept] += creds;
    }
  }
  return load;
};

// console.log(shibo.courseLoad());

Course.prototype.addStudent = function(stud) {
  stud.enroll(this);
};

ruby.addStudent(shibo);
// console.log(shibo.courses);
// console.log(ruby.students);
