(function() {
  module.exports = {
    index: function(req, res) {
      return res.render('index', {
        seed: {
          test: 2
        }
      });
    }
  };

}).call(this);
