var assert = require('assert');
var getIn = require('../index.js');

console.log(getIn);

var employee = {
    empFirstName: "Nanak",
    empLastName: "Chand",
    address: {
        home: {
            addressLines: {
                1: "F7 Stanley Street",
                2: "Swindon"
            }
        }
    },
    employeeType : {
        retail: {
            channel: "Top100",
            spending: "Top10",
        }
    }
};
describe('Index', function() {
  describe('#getIn', function() {
    it('Should throw error for invalid JSON', function() {
      assert.throws(function () { getIn("", ["key"]) }, Error, "Invalid JSON");
    });
    it('Should throw error for invalid Keys', function() {
      assert.throws(function () { getIn(employee, []) }, Error, "Invalid Keys");
    });
    it('Should give the empFirstName ', function () {
          assert.equal(getIn(employee,['empFirstName']), employee.empFirstName);
    });  
    it('Should give the  employee.address.home.addressLines', function () {
          assert.equal(getIn(employee,[ "address", "home", "addressLines"]), employee.address.home.addressLines);
    });
    it('Should give the  employee.address.home.addressLines[2]', function () {
          assert.equal(getIn(employee,[ "address", "home", "addressLines","2"]), employee.address.home.addressLines[2]);
    });
    it('Should give the null', function () {
          assert.equal(getIn(employee,["hello", "none", "reve", "hello"]), null);
    }); 
  });
});
