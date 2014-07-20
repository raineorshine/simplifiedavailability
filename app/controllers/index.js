(function() {
  var controller;

  controller = {
    index: function(req, res) {
      return res.render('index', {
        seed: {
          test: 2
        }
      });
    }
  };

  module.exports = controller;

}).call(this);
