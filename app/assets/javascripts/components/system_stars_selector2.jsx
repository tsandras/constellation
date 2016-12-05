this.SystemStars = React.createClass({
  getInitialState: function() {
    return {
      stelSys: this.props.stelSys
    };
  },
  updateCanvas: function() {
    this.props.stelSys.constructTree();
    return this.props.stelSys.draw('canvas' + this.props.num);
  },
  componentDidMount: function() {
    return this.updateCanvas();
  },
  chooseStarSystem: function(e) {
    this.props.selector.setState({
      showSystemStars: false
    });
    var tmp = this.state.stelSys.standardCode
    return $.post('/systems', {
      system: {
        standard_code: this.props.stelSys.standardCode
      }
    }, (function(_this) {
      return function(data) {
        ReactDOM.render(<div dangerouslySetInnerHTML={{__html: tmp}} />, document.getElementById('system-displaying'));
        return console.log(data);
      };
    })(this), 'JSON');
  },
  render: function() {
    return React.DOM.div({
      className: 'system-stars',
      onClick: this.chooseStarSystem
    }, this.props.stelSys.standardCode, React.DOM.canvas({
      id: 'canvas' + this.props.num,
      width: '100',
      height: '100',
      name: this.props.stelSys.standardCode
    }));
  }
});

this.SystemStarsDisplay = React.createClass({
  getInitialState: function() {
    var i, len, ref, standardCode, tmp;
    tmp = [];
    ref = this.props.standard_codes;
    for (i = 0, len = ref.length; i < len; i++) {
      standardCode = ref[i];
      tmp.push(new StellarSystem(standardCode));
    }
    return {
      stellarSystems: tmp
    };
  },
  render: function() {
    var key, stellarSystem;
    return React.DOM.div({
      className: 'systems'
    }, (function() {
      var i, len, ref, results;
      ref = this.state.stellarSystems;
      results = [];
      for (key = i = 0, len = ref.length; i < len; key = ++i) {
        stellarSystem = ref[key];
        results.push(React.createElement(SystemStars, {
          stelSys: stellarSystem,
          key: key,
          num: key,
          selector: this.props.selector
        }));
      }
      return results;
    }).call(this));
  }
});

this.SystemStarsSelector = React.createClass({
  getInitialState: function() {
    return {
      showSystemStars: false
    };
  },
  handleSystemStars: function(e) {
    if (this.state.showSystemStars) {
      return this.setState({
        showSystemStars: false
      });
    } else {
      return this.setState({
        showSystemStars: true
      });
    }
  },
  render: function() {
    return React.DOM.div({
      className: 'system-stars-handle'
    }, React.DOM.span({
      onClick: this.handleSystemStars,
      className: 'system-stars-selector'
    }, 'Stellar system'), this.state.showSystemStars ? React.createElement(SystemStarsDisplay, {
      standard_codes: this.props.standard_codes,
      selector: this
    }) : void 0);
  }
});
